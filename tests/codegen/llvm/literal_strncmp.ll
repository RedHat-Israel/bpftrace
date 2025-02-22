; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf-pc-linux"

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64 %0, i64 %1) #0

define i64 @"kretprobe:vfs_read"(i8* %0) section "s_kretprobe:vfs_read_1" !dbg !4 {
entry:
  %initial_value = alloca i64, align 8
  %lookup_elem_val = alloca i64, align 8
  %comm5 = alloca [16 x i8], align 1
  %strcmp.result = alloca i1, align 1
  %comm = alloca [16 x i8], align 1
  %1 = bitcast [16 x i8]* %comm to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %1)
  %2 = bitcast [16 x i8]* %comm to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %2, i8 0, i64 16, i1 false)
  %get_comm = call i64 inttoptr (i64 16 to i64 ([16 x i8]*, i64)*)([16 x i8]* %comm, i64 16)
  %3 = bitcast i1* %strcmp.result to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %3)
  store i1 true, i1* %strcmp.result, align 1
  %4 = getelementptr [16 x i8], [16 x i8]* %comm, i32 0, i32 0
  %5 = load i8, i8* %4, align 1
  %strcmp.cmp = icmp ne i8 %5, 115
  br i1 %strcmp.cmp, label %strcmp.false, label %strcmp.loop_null_cmp

pred_false:                                       ; preds = %strcmp.false
  ret i64 0

pred_true:                                        ; preds = %strcmp.false
  %6 = bitcast [16 x i8]* %comm to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %6)
  %7 = bitcast [16 x i8]* %comm5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %7)
  %8 = bitcast [16 x i8]* %comm5 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %8, i8 0, i64 16, i1 false)
  %get_comm6 = call i64 inttoptr (i64 16 to i64 ([16 x i8]*, i64)*)([16 x i8]* %comm5, i64 16)
  %pseudo = call i64 @llvm.bpf.pseudo(i64 1, i64 0)
  %lookup_elem = call i8* inttoptr (i64 1 to i8* (i64, [16 x i8]*)*)(i64 %pseudo, [16 x i8]* %comm5)
  %9 = bitcast i64* %lookup_elem_val to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %9)
  %map_lookup_cond = icmp ne i8* %lookup_elem, null
  br i1 %map_lookup_cond, label %lookup_success, label %lookup_failure

strcmp.false:                                     ; preds = %strcmp.done, %strcmp.loop, %entry
  %10 = load i1, i1* %strcmp.result, align 1
  %11 = bitcast i1* %strcmp.result to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %11)
  %12 = zext i1 %10 to i64
  %predcond = icmp eq i64 %12, 0
  br i1 %predcond, label %pred_false, label %pred_true

strcmp.done:                                      ; preds = %strcmp.loop1, %strcmp.loop_null_cmp2, %strcmp.loop_null_cmp
  store i1 false, i1* %strcmp.result, align 1
  br label %strcmp.false

strcmp.loop:                                      ; preds = %strcmp.loop_null_cmp
  %13 = getelementptr [16 x i8], [16 x i8]* %comm, i32 0, i32 1
  %14 = load i8, i8* %13, align 1
  %strcmp.cmp3 = icmp ne i8 %14, 115
  br i1 %strcmp.cmp3, label %strcmp.false, label %strcmp.loop_null_cmp2

strcmp.loop_null_cmp:                             ; preds = %entry
  %strcmp.cmp_null = icmp eq i8 %5, 0
  br i1 %strcmp.cmp_null, label %strcmp.done, label %strcmp.loop

strcmp.loop1:                                     ; preds = %strcmp.loop_null_cmp2
  br label %strcmp.done

strcmp.loop_null_cmp2:                            ; preds = %strcmp.loop
  %strcmp.cmp_null4 = icmp eq i8 %14, 0
  br i1 %strcmp.cmp_null4, label %strcmp.done, label %strcmp.loop1

lookup_success:                                   ; preds = %pred_true
  %cast = bitcast i8* %lookup_elem to i64*
  %15 = load i64, i64* %cast, align 8
  %16 = add i64 %15, 1
  store i64 %16, i64* %cast, align 8
  br label %lookup_merge

lookup_failure:                                   ; preds = %pred_true
  %17 = bitcast i64* %initial_value to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %17)
  store i64 1, i64* %initial_value, align 8
  %pseudo7 = call i64 @llvm.bpf.pseudo(i64 1, i64 0)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, [16 x i8]*, i64*, i64)*)(i64 %pseudo7, [16 x i8]* %comm5, i64* %initial_value, i64 1)
  %18 = bitcast i64* %initial_value to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %18)
  br label %lookup_merge

lookup_merge:                                     ; preds = %lookup_failure, %lookup_success
  %19 = bitcast i64* %lookup_elem_val to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %19)
  %20 = bitcast [16 x i8]* %comm5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %20)
  ret i64 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg %0, i8* nocapture %1) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly %0, i8 %1, i64 %2, i1 immarg %3) #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg %0, i8* nocapture %1) #1

attributes #0 = { nounwind }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { argmemonly nofree nosync nounwind willreturn writeonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "bpftrace", isOptimized: false, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2)
!1 = !DIFile(filename: "bpftrace.bpf.o", directory: ".")
!2 = !{}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = distinct !DISubprogram(name: "kretprobe_vfs_read", linkageName: "kretprobe_vfs_read", scope: !1, file: !1, type: !5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !10)
!5 = !DISubroutineType(types: !6)
!6 = !{!7, !8}
!7 = !DIBasicType(name: "int64", size: 64, encoding: DW_ATE_signed)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int8", size: 8, encoding: DW_ATE_signed)
!10 = !{!11, !12}
!11 = !DILocalVariable(name: "var0", scope: !4, file: !1, type: !7)
!12 = !DILocalVariable(name: "var1", arg: 1, scope: !4, file: !1, type: !8)
