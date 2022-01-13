xv6 is a re-implementation of Dennis Ritchie's and Ken Thompson's Unix
Version 6 (v6).  xv6 loosely follows the structure and style of v6,
but is implemented for a modern RISC-V multiprocessor using ANSI C.

ACKNOWLEDGMENTS

xv6 is inspired by John Lions's Commentary on UNIX 6th Edition (Peer
to Peer Communications; ISBN: 1-57398-013-7; 1st edition (June 14,
2000)). See also https://pdos.csail.mit.edu/6.828/, which
provides pointers to on-line resources for v6.

The following people have made contributions: Russ Cox (context switching,
locking), Cliff Frey (MP), Xiao Yu (MP), Nickolai Zeldovich, and Austin
Clements.

We are also grateful for the bug reports and patches contributed by
Takahiro Aoyagi, Silas Boyd-Wickizer, Anton Burtsev, Ian Chen, Dan
Cross, Cody Cutler, Mike CAT, Tej Chajed, Asami Doi, eyalz800, Nelson
Elhage, Saar Ettinger, Alice Ferrazzi, Nathaniel Filardo, flespark,
Peter Froehlich, Yakir Goaron,Shivam Handa, Matt Harvey, Bryan Henry,
jaichenhengjie, Jim Huang, Matúš Jókay, Alexander Kapshuk, Anders
Kaseorg, kehao95, Wolfgang Keller, Jungwoo Kim, Jonathan Kimmitt,
Eddie Kohler, Vadim Kolontsov , Austin Liew, l0stman, Pavan
Maddamsetti, Imbar Marinescu, Yandong Mao, , Matan Shabtay, Hitoshi
Mitake, Carmi Merimovich, Mark Morrissey, mtasm, Joel Nider,
OptimisticSide, Greg Price, Jude Rich, Ayan Shafqat, Eldar Sehayek,
Yongming Shen, Fumiya Shigemitsu, Cam Tenny, tyfkda, Warren Toomey,
Stephen Tu, Rafael Ubal, Amane Uehara, Pablo Ventura, Xi Wang, Keiichi
Watanabe, Nicolas Wolovick, wxdao, Grant Wu, Jindong Zhang, Icenowy
Zheng, ZhUyU1997, and Zou Chang Wei.

The code in the files that constitute xv6 is
Copyright 2006-2020 Frans Kaashoek, Robert Morris, and Russ Cox.

ERROR REPORTS

Please send errors and suggestions to Frans Kaashoek and Robert Morris
(kaashoek,rtm@mit.edu). The main purpose of xv6 is as a teaching
operating system for MIT's 6.S081, so we are more interested in
simplifications and clarifications than new features.

BUILDING AND RUNNING XV6

You will need a RISC-V "newlib" tool chain from
https://github.com/riscv/riscv-gnu-toolchain, and qemu compiled for
riscv64-softmmu. Once they are installed, and in your shell
search path, you can run "make qemu".

# ============== debug uservec
```
uservec:    
        #
        # trap.c sets stvec to point here, so
        # traps from user space start here,
        # in supervisor mode, but with a
        # user page table.
        #
        # sscratch points to where the process's p->trapframe is
        # mapped into user space, at TRAPFRAME.
        #
        
        # swap a0 and sscratch
        # so that a0 is TRAPFRAME
        csrrw a0, sscratch, a0

        # save the user registers in TRAPFRAME
        sd ra, 40(a0)
        sd sp, 48(a0)
        sd gp, 56(a0)
        sd tp, 64(a0)
        sd t0, 72(a0)
        sd t1, 80(a0)
        sd t2, 88(a0)
        sd s0, 96(a0)
        sd s1, 104(a0)
        sd a1, 120(a0)
        sd a2, 128(a0)
        sd a3, 136(a0)
        sd a4, 144(a0)
        sd a5, 152(a0)
        sd a6, 160(a0)
        sd a7, 168(a0)
        sd s2, 176(a0)
        sd s3, 184(a0)
        sd s4, 192(a0)
        sd s5, 200(a0)
        sd s6, 208(a0)
        sd s7, 216(a0)
        sd s8, 224(a0)
        sd s9, 232(a0)
        sd s10, 240(a0)
        sd s11, 248(a0)
        sd t3, 256(a0)
        sd t4, 264(a0)
        sd t5, 272(a0)
        sd t6, 280(a0)

        # save the user a0 in p->trapframe->a0
        csrr t0, sscratch
        sd t0, 112(a0)

        # restore kernel stack pointer from p->trapframe->kernel_sp
        ld sp, 8(a0)

        # make tp hold the current hartid, from p->trapframe->kernel_hartid
        ld tp, 32(a0)

        # load the address of usertrap(), p->trapframe->kernel_trap
        ld t0, 16(a0)

        # restore kernel page table from p->trapframe->kernel_satp
        ld t1, 0(a0)
        csrw satp, t1
        sfence.vma zero, zero

        # a0 is no longer valid, since the kernel page
        # table does not specially map p->tf.
        PUTACHAR a3,a4,a5,0x63
        PUTACHAR a3,a4,a5,0x61
        PUTACHAR a3,a4,a5,0x6c
        PUTACHAR a3,a4,a5,0x6c
        PUTACHAR a3,a4,a5,0x20
        # jump to usertrap(), which does not return
        jr t0

```

# ============== debug log

```
qemu-system-riscv64 -machine virt -bios none -kernel kernel/kernel -m 128M -smp 3 -nographic -drive file=fs.img,if=none,format=raw,id=x0 -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0

xv6 kernel is booting

hart 2 starting
hart 1 starting
usertrapret  sepc=0 sstatus=20, satp=87fff, user satp = 87f76 
call usertrap  sepc=14 sstatus=20  scause = 8 
page table 0x0000000087f6f000
..0: pte 0x0000000021fdac01 pa 0x0000000087f6b000
.. ..0: pte 0x0000000021fda801 pa 0x0000000087f6a000
.. .. ..0: pte 0x0000000021fdb01f pa 0x0000000087f6c000
.. .. ..1: pte 0x0000000021fda40f pa 0x0000000087f69000
.. .. ..2: pte 0x0000000021fda01f pa 0x0000000087f68000
..255: pte 0x0000000021fdb801 pa 0x0000000087f6e000
.. ..511: pte 0x0000000021fdb401 pa 0x0000000087f6d000
.. .. ..510: pte 0x0000000021fddc07 pa 0x0000000087f77000
.. .. ..511: pte 0x0000000020001c0b pa 0x0000000080007000
usertrapret  sepc=0 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=3b0 sstatus=20  scause = 8 
kerneltrap timer interrupt ,old  sepc=-7ffff390 old sstatus=120  sepc=-7ffff390 sstatus=120
usertrapret  sepc=3b4 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=3b8 sstatus=20  scause = 8 
usertrapret  sepc=3bc sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=3b0 sstatus=20  scause = 8 
usertrapret  sepc=3b4 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=3e8 sstatus=20  scause = 8 
usertrapret  sepc=3ec sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=3e8 sstatus=20  scause = 8 
usertrapret  sepc=3ec sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
iusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
nusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
iusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
tusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
:usertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
 usertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
susertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
tusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
ausertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
rusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
tusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
iusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
kerneltrap timer interrupt ,old  sepc=-7fffd6da old sstatus=120  sepc=-7fffd6da sstatus=120
nusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
gusertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
 usertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
susertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 
husertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=390 sstatus=20  scause = 8 

usertrapret  sepc=394 sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap  sepc=368 sstatus=20  scause = 8 
usertrapret  sepc=36c sstatus=20, satp=87fff, user satp = 87f6f 
usertrapret  sepc=36c sstatus=20, satp=87fff, user satp = 87f76 
call usertrap  sepc=36c sstatus=20  scause = 9 
usertrapret  sepc=36c sstatus=20, satp=87fff, user satp = 87f6f 
call usertrap call  sepc=36c sstatus=20  scause = 9 
usertrap  sepc=378 sstatus=20  scause = 8 
usertrapret  sepc=36c sstatus=20, satp=87fff, user satp = 87f76 
call usertrap  sepc=3a8 sstatus=20  scause = 8 
usertrapret  sepc=a60 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=e0c sstatus=20  scause = 8 
usertrapret  sepc=e10 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=df4 sstatus=20  scause = 8 
usertrapret  sepc=df8 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=dec sstatus=20  scause = 8 
$usertrapret  sepc=df0 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=dec sstatus=20  scause = 8 
 usertrapret  sepc=df0 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=de4 sstatus=20  scause = 8 

usertrapret  sepc=de8 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=dc4 sstatus=20  scause = 8 
usertrapret  sepc=dc8 sstatus=20, satp=87fff, user satp = 87f64 
usertraprecall t  sepc=dc8 sstatus=20, satp=87fff, user satp = 87f76 
usertrap  sepc=dd4 sstatus=20  scause = 8 
call usertrap  sepc=e54 sstatus=20  scause = 8 
usertrapret  sepc=e58 sstatus=20, satp=87fff, user satp = 87f76 
call usertrap  sepc=dcc sstatus=20  scause = 8 
usertrapret  sepc=dd8 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=dec sstatus=20  scause = 8 
$usertrapret  sepc=df0 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=dec sstatus=20  scause = 8 
 usertrapret  sepc=df0 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=de4 sstatus=20  scause = 8 

usertrapret  sepc=de8 sstatus=20, satp=87fff, user satp = 87f64 
call usertrap  sepc=dc4 sstatus=20  scause = 8 
kerneltrap timer interrupt ,old  sepc=-7fffd6da old sstatus=120  sepc=-7fffd6da sstatus=120
```
**kerneltrap sstatus=120**

**usertrap  sstatus=20**
