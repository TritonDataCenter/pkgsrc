$NetBSD$

Disable -fomit-frame-pointer.
Support -fstrict-calling-conventions and -msave-args.

--- gcc/config/i386/i386.c.orig	2018-01-16 12:49:29.534125000 +0000
+++ gcc/config/i386/i386.c
@@ -2572,6 +2572,9 @@ static unsigned int ix86_minimum_incomin
 
 static enum calling_abi ix86_function_abi (const_tree);
 
+static int ix86_nsaved_args (void);
+static void pro_epilogue_adjust_stack (rtx, rtx, rtx, int, bool);
+
 
 #ifndef SUBTARGET32_DEFAULT_CPU
 #define SUBTARGET32_DEFAULT_CPU "i386"
@@ -5847,7 +5850,7 @@ ix86_option_override_internal (bool main
     }
 
   /* Keep nonleaf frame pointers.  */
-  if (opts->x_flag_omit_frame_pointer)
+  if (0)
     opts->x_target_flags &= ~MASK_OMIT_LEAF_FRAME_POINTER;
   else if (TARGET_OMIT_LEAF_FRAME_POINTER_P (opts->x_target_flags))
     opts->x_flag_omit_frame_pointer = 1;
@@ -5896,6 +5899,9 @@ ix86_option_override_internal (bool main
       &= ~((OPTION_MASK_ISA_BMI | OPTION_MASK_ISA_BMI2 | OPTION_MASK_ISA_TBM)
 	   & ~opts->x_ix86_isa_flags_explicit);
 
+  if (!TARGET_64BIT && TARGET_SAVE_ARGS)
+    warning (0, "-msave-args is ignored in 32-bit mode");
+
   /* Validate -mpreferred-stack-boundary= value or default it to
      PREFERRED_STACK_BOUNDARY_DEFAULT.  */
   ix86_preferred_stack_boundary = PREFERRED_STACK_BOUNDARY_DEFAULT;
@@ -8015,6 +8021,7 @@ ix86_function_regparm (const_tree type,
 	 and callee not, or vice versa.  Instead look at whether the callee
 	 is optimized or not.  */
       if (target && opt_for_fn (target->decl, optimize)
+	  && !flag_strict_calling_conventions
 	  && !(profile_flag && !flag_fentry))
 	{
 	  cgraph_local_info *i = &target->local;
@@ -8112,6 +8119,7 @@ ix86_function_sseregparm (const_tree typ
       /* TARGET_SSE_MATH */
       && (target_opts_for_fn (target->decl)->x_ix86_fpmath & FPMATH_SSE)
       && opt_for_fn (target->decl, optimize)
+      && !flag_strict_calling_conventions
       && !(profile_flag && !flag_fentry))
     {
       cgraph_local_info *i = &target->local;
@@ -11964,7 +11972,7 @@ ix86_can_use_return_insn_p (void)
   ix86_compute_frame_layout ();
   struct ix86_frame &frame = cfun->machine->frame;
   return (frame.stack_pointer_offset == UNITS_PER_WORD
-	  && (frame.nregs + frame.nsseregs) == 0);
+	  && (frame.nmsave_args + frame.nregs + frame.nsseregs) == 0);
 }
 
 /* Value should be nonzero if functions must have frame pointers.
@@ -11988,6 +11996,9 @@ ix86_frame_pointer_required (void)
   if (TARGET_32BIT_MS_ABI && cfun->calls_setjmp)
     return true;
 
+  if (TARGET_64BIT && TARGET_SAVE_ARGS)
+    return true;
+
   /* Win64 SEH, very large frames need a frame-pointer as maximum stack
      allocation is 4GB.  */
   if (TARGET_64BIT_MS_ABI && get_frame_size () > SEH_MAX_FRAME_SIZE)
@@ -12781,6 +12792,7 @@ ix86_compute_frame_layout (void)
 
   frame->nregs = ix86_nsaved_regs ();
   frame->nsseregs = ix86_nsaved_sseregs ();
+  frame->nmsave_args = ix86_nsaved_args ();
 
   /* 64-bit MS ABI seem to require stack alignment to be always 16,
      except for function prologues, leaf functions and when the defult
@@ -12843,7 +12855,8 @@ ix86_compute_frame_layout (void)
     }
 
   frame->save_regs_using_mov
-    = (TARGET_PROLOGUE_USING_MOVE && cfun->machine->use_fast_prologue_epilogue
+    = ((TARGET_FORCE_SAVE_REGS_USING_MOV ||
+       (TARGET_PROLOGUE_USING_MOVE && cfun->machine->use_fast_prologue_epilogue))
        /* If static stack checking is enabled and done with probes,
 	  the registers need to be saved before allocating the frame.  */
        && flag_stack_check != STATIC_BUILTIN_STACK_CHECK);
@@ -12863,6 +12876,13 @@ ix86_compute_frame_layout (void)
   /* The traditional frame pointer location is at the top of the frame.  */
   frame->hard_frame_pointer_offset = offset;
 
+  if (TARGET_64BIT && TARGET_SAVE_ARGS)
+    {
+      offset += frame->nmsave_args * UNITS_PER_WORD;
+      offset += (frame->nmsave_args % 2) * UNITS_PER_WORD;
+    }
+  frame->arg_save_offset = offset;
+
   /* Register save area */
   offset += frame->nregs * UNITS_PER_WORD;
   frame->reg_save_offset = offset;
@@ -12945,7 +12965,7 @@ ix86_compute_frame_layout (void)
   /* Size prologue needs to allocate.  */
   to_allocate = offset - frame->sse_reg_save_offset;
 
-  if ((!to_allocate && frame->nregs <= 1)
+  if ((!TARGET_SAVE_ARGS && !to_allocate && frame->nregs <= 1)
       || (TARGET_64BIT && to_allocate >= HOST_WIDE_INT_C (0x80000000)))
     frame->save_regs_using_mov = false;
 
@@ -12957,7 +12977,11 @@ ix86_compute_frame_layout (void)
     {
       frame->red_zone_size = to_allocate;
       if (frame->save_regs_using_mov)
-	frame->red_zone_size += frame->nregs * UNITS_PER_WORD;
+	{
+	  frame->red_zone_size += frame->nregs * UNITS_PER_WORD;
+	  frame->red_zone_size += frame->nmsave_args * UNITS_PER_WORD;
+	  frame->red_zone_size += (frame->nmsave_args % 2) * UNITS_PER_WORD;
+	}
       if (frame->red_zone_size > RED_ZONE_SIZE - RED_ZONE_RESERVE)
 	frame->red_zone_size = RED_ZONE_SIZE - RED_ZONE_RESERVE;
     }
@@ -12988,6 +13012,20 @@ ix86_compute_frame_layout (void)
 	  frame->hard_frame_pointer_offset = frame->stack_pointer_offset - 128;
 	}
     }
+  if (getenv("DEBUG_FRAME_STUFF") != NULL)
+    {
+      printf("nmsave_args: %d\n", frame->nmsave_args);
+      printf("nsseregs: %d\n", frame->nsseregs);
+      printf("nregs: %d\n", frame->nregs);
+
+      printf("frame_pointer_offset: %llx\n", frame->frame_pointer_offset);
+      printf("hard_frame_pointer_offset: %llx\n", frame->hard_frame_pointer_offset);
+      printf("stack_pointer_offset: %llx\n", frame->stack_pointer_offset);
+      printf("hfp_save_offset: %llx\n", frame->hfp_save_offset);
+      printf("arg_save_offset: %llx\n", frame->arg_save_offset);
+      printf("reg_save_offset: %llx\n", frame->reg_save_offset);
+      printf("sse_reg_save_offset: %llx\n", frame->sse_reg_save_offset);
+    }
 }
 
 /* This is semi-inlined memory_address_length, but simplified
@@ -13096,6 +13134,23 @@ ix86_emit_save_regs (void)
   unsigned int regno;
   rtx_insn *insn;
 
+  if (TARGET_64BIT && TARGET_SAVE_ARGS)
+    {
+      int i;
+      int nsaved = ix86_nsaved_args ();
+      int start = cfun->returns_struct;
+
+      for (i = start; i < start + nsaved; i++)
+	{
+	  regno = x86_64_int_parameter_registers[i];
+	  insn = emit_insn (gen_push (gen_rtx_REG (word_mode, regno)));
+	  RTX_FRAME_RELATED_P (insn) = 1;
+	}
+      if (nsaved % 2 != 0)
+	pro_epilogue_adjust_stack (stack_pointer_rtx, stack_pointer_rtx,
+				   GEN_INT (-UNITS_PER_WORD), -1, false);
+    }
+
   for (regno = FIRST_PSEUDO_REGISTER - 1; regno-- > 0; )
     if (GENERAL_REGNO_P (regno) && ix86_save_reg (regno, true))
       {
@@ -13174,9 +13229,30 @@ ix86_emit_save_reg_using_mov (machine_mo
 /* Emit code to save registers using MOV insns.
    First register is stored at CFA - CFA_OFFSET.  */
 static void
-ix86_emit_save_regs_using_mov (HOST_WIDE_INT cfa_offset)
+ix86_emit_save_regs_using_mov (const struct ix86_frame *frame)
 {
   unsigned int regno;
+  HOST_WIDE_INT cfa_offset = frame->arg_save_offset;
+
+  if (TARGET_64BIT && TARGET_SAVE_ARGS)
+    {
+      int i;
+      int nsaved = ix86_nsaved_args ();
+      int start = cfun->returns_struct;
+
+      /* We deal with this twice? */
+      if (nsaved % 2 != 0)
+	cfa_offset -= UNITS_PER_WORD;
+
+      for (i = start + nsaved - 1; i >= start; i--)
+	{
+	  regno = x86_64_int_parameter_registers[i];
+	  ix86_emit_save_reg_using_mov(word_mode, regno, cfa_offset);
+	  cfa_offset -= UNITS_PER_WORD;
+	}
+    }
+
+  cfa_offset = frame->reg_save_offset;
 
   for (regno = 0; regno < FIRST_PSEUDO_REGISTER; regno++)
     if (GENERAL_REGNO_P (regno) && ix86_save_reg (regno, true))
@@ -13960,7 +14036,7 @@ ix86_finalize_stack_realign_flags (void)
   if (stack_realign
       && frame_pointer_needed
       && crtl->is_leaf
-      && flag_omit_frame_pointer
+      && 0
       && crtl->sp_is_unchanging
       && !ix86_current_function_calls_tls_descriptor
       && !crtl->accesses_prior_frames
@@ -14235,7 +14311,7 @@ ix86_expand_prologue (void)
 	}
     }
 
-  int_registers_saved = (frame.nregs == 0);
+  int_registers_saved = (frame.nregs == 0 && frame.nmsave_args == 0);
   sse_registers_saved = (frame.nsseregs == 0);
 
   if (frame_pointer_needed && !m->fs.fp_valid)
@@ -14286,7 +14362,7 @@ ix86_expand_prologue (void)
 	       && (! TARGET_STACK_PROBE
 		   || frame.stack_pointer_offset < CHECK_STACK_LIMIT))
 	{
-	  ix86_emit_save_regs_using_mov (frame.reg_save_offset);
+	  ix86_emit_save_regs_using_mov (&frame);
 	  int_registers_saved = true;
 	}
     }
@@ -14529,7 +14605,7 @@ ix86_expand_prologue (void)
     }
 
   if (!int_registers_saved)
-    ix86_emit_save_regs_using_mov (frame.reg_save_offset);
+    ix86_emit_save_regs_using_mov (&frame);
   if (!sse_registers_saved)
     ix86_emit_save_sse_regs_using_mov (frame.sse_reg_save_offset);
 
@@ -14968,6 +15044,35 @@ ix86_expand_epilogue (int style)
       ix86_emit_restore_regs_using_pop ();
     }
 
+  if (TARGET_64BIT && TARGET_SAVE_ARGS) {
+    /*
+     * For each saved argument, emit a restore note, to make sure it happens
+     * correctly within the shrink wrapping (I think).
+     *
+     * Note that 'restore' in this case merely means the rule is the same as
+     * it was on function entry, not that we have actually done a register
+     * restore (which of course, we haven't).
+     *
+     * If we do not do this, the DWARF code will emit sufficient restores to
+     * provide balance on its own initiative, which in the presence of
+     * -fshrink-wrap may actually _introduce_ unbalance (whereby we only
+     * .cfi_offset a register sometimes, but will always .cfi_restore it.
+     * This will trip an assert.)
+     */
+    int start = cfun->returns_struct;
+    int nsaved = ix86_nsaved_args();
+    int i;
+
+    for (i = start + nsaved - 1; i >= start; i--)
+      queued_cfa_restores
+	= alloc_reg_note (REG_CFA_RESTORE,
+			  gen_rtx_REG(Pmode,
+				      x86_64_int_parameter_registers[i]),
+			  queued_cfa_restores);
+
+    gcc_assert(m->fs.fp_valid);
+  }
+
   /* If we used a stack pointer and haven't already got rid of it,
      then do so now.  */
   if (m->fs.fp_valid)
@@ -15979,6 +16084,18 @@ ix86_cannot_force_const_mem (machine_mod
   return !ix86_legitimate_constant_p (mode, x);
 }
 
+/* Return number of arguments to be saved on the stack with
+   -msave-args.  */
+
+static int
+ix86_nsaved_args (void)
+{
+  if (TARGET_64BIT && TARGET_SAVE_ARGS)
+    return crtl->args.info.regno - cfun->returns_struct;
+  else
+    return 0;
+}
+
 /*  Nonzero if the symbol is marked as dllimport, or as stub-variable,
     otherwise zero.  */
 
