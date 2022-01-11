
# .gdbinit
```
cat .gdbinit
set confirm off
set architecture riscv:rv64
target remote 127.0.0.1:25000
symbol-file kernel/kernel
set disassemble-next-line auto
set riscv use-compressed-breakpoints yes
```

#  make qemu-gdb

```
make qemu-gdb
/opt/riscv/bin/riscv64-linux-gnu-gdb kernel/kernel
(gdb) target remote localhost:25000
Remote debugging using localhost:25000
0x0000000000001000 in ?? ()
(gdb) b syscall
Breakpoint 1 at 0x80002ad0: file kernel/syscall.c, line 134.
(gdb) c
Continuing.
[Switching to Thread 1.2]

Thread 2 hit Breakpoint 1, syscall () at kernel/syscall.c:134
134     {
(gdb) bt
#0  syscall () at kernel/syscall.c:134
#1  0x00000000800027f8 in usertrap () at kernel/trap.c:67
#2  0x0505050505050505 in ?? ()
```


```
p->trapframe->kernel_trap = (uint64)usertrap
usertrap(void) -->syscall(void)
void
syscall(void)
{
  int num;
  struct proc *p = myproc();

  num = p->trapframe->a7;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    p->trapframe->a0 = syscalls[num]();
  } else {
    printf("%d %s: unknown sys call %d\n",
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
  }
}
```
# uservec kernel_trap

w_stvec(TRAMPOLINE + (uservec - trampoline))

```
        # load the address of usertrap(), p->trapframe->kernel_trap
        ld t0, 16(a0)

        # restore kernel page table from p->trapframe->kernel_satp
        ld t1, 0(a0)
        csrw satp, t1
        sfence.vma zero, zero

        # a0 is no longer valid, since the kernel page
        # table does not specially map p->tf.

        # jump to usertrap(), which does not return
        jr t0
```

#  exec(init, argv) 

```
# exec(init, argv)
.globl start
start:
        la a0, init
        la a1, argv
        li a7, SYS_exec
        ecall
```
