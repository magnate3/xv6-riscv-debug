
user/_nice-exit:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"
#include "kernel/syscall.h"
#include "kernel/memlayout.h"
#include "kernel/riscv.h"

int main(){
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	06400493          	li	s1,100
  10:	a809                	j	22 <main+0x22>
  for(int i=0; i < 100; i++){
    int pid = fork();
    if(pid>0){
      int pid2 = fork();
  12:	00000097          	auipc	ra,0x0
  16:	336080e7          	jalr	822(ra) # 348 <fork>
      if(pid2>0){
  1a:	02a04163          	bgtz	a0,3c <main+0x3c>
  for(int i=0; i < 100; i++){
  1e:	34fd                	addiw	s1,s1,-1
  20:	c4a1                	beqz	s1,68 <main+0x68>
    int pid = fork();
  22:	00000097          	auipc	ra,0x0
  26:	326080e7          	jalr	806(ra) # 348 <fork>
  2a:	892a                	mv	s2,a0
    if(pid>0){
  2c:	fea043e3          	bgtz	a0,12 <main+0x12>
          if(nice(pid,4) != 1) break;
          if(nice(pid,5) != 1) break;
        }
        exit(0);
      }
    } else if(pid == 0){
  30:	f57d                	bnez	a0,1e <main+0x1e>
      exit(0);
  32:	4501                	li	a0,0
  34:	00000097          	auipc	ra,0x0
  38:	31c080e7          	jalr	796(ra) # 350 <exit>
          if(nice(pid,4) != 1) break;
  3c:	4485                	li	s1,1
  3e:	4591                	li	a1,4
  40:	854a                	mv	a0,s2
  42:	00000097          	auipc	ra,0x0
  46:	3b6080e7          	jalr	950(ra) # 3f8 <nice>
  4a:	00951a63          	bne	a0,s1,5e <main+0x5e>
          if(nice(pid,5) != 1) break;
  4e:	4595                	li	a1,5
  50:	854a                	mv	a0,s2
  52:	00000097          	auipc	ra,0x0
  56:	3a6080e7          	jalr	934(ra) # 3f8 <nice>
  5a:	fe9502e3          	beq	a0,s1,3e <main+0x3e>
        exit(0);
  5e:	4501                	li	a0,0
  60:	00000097          	auipc	ra,0x0
  64:	2f0080e7          	jalr	752(ra) # 350 <exit>
    }
  }
  exit(1);
  68:	4505                	li	a0,1
  6a:	00000097          	auipc	ra,0x0
  6e:	2e6080e7          	jalr	742(ra) # 350 <exit>

0000000000000072 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  72:	1141                	addi	sp,sp,-16
  74:	e422                	sd	s0,8(sp)
  76:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  78:	87aa                	mv	a5,a0
  7a:	0585                	addi	a1,a1,1
  7c:	0785                	addi	a5,a5,1
  7e:	fff5c703          	lbu	a4,-1(a1)
  82:	fee78fa3          	sb	a4,-1(a5)
  86:	fb75                	bnez	a4,7a <strcpy+0x8>
    ;
  return os;
}
  88:	6422                	ld	s0,8(sp)
  8a:	0141                	addi	sp,sp,16
  8c:	8082                	ret

000000000000008e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e422                	sd	s0,8(sp)
  92:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  94:	00054783          	lbu	a5,0(a0)
  98:	cf91                	beqz	a5,b4 <strcmp+0x26>
  9a:	0005c703          	lbu	a4,0(a1)
  9e:	00f71b63          	bne	a4,a5,b4 <strcmp+0x26>
    p++, q++;
  a2:	0505                	addi	a0,a0,1
  a4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	c789                	beqz	a5,b4 <strcmp+0x26>
  ac:	0005c703          	lbu	a4,0(a1)
  b0:	fef709e3          	beq	a4,a5,a2 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  b4:	0005c503          	lbu	a0,0(a1)
}
  b8:	40a7853b          	subw	a0,a5,a0
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strlen>:

uint
strlen(const char *s)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cf91                	beqz	a5,e8 <strlen+0x26>
  ce:	0505                	addi	a0,a0,1
  d0:	87aa                	mv	a5,a0
  d2:	4685                	li	a3,1
  d4:	9e89                	subw	a3,a3,a0
  d6:	00f6853b          	addw	a0,a3,a5
  da:	0785                	addi	a5,a5,1
  dc:	fff7c703          	lbu	a4,-1(a5)
  e0:	fb7d                	bnez	a4,d6 <strlen+0x14>
    ;
  return n;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret
  for(n = 0; s[n]; n++)
  e8:	4501                	li	a0,0
  ea:	bfe5                	j	e2 <strlen+0x20>

00000000000000ec <memset>:

void*
memset(void *dst, int c, uint n)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f2:	ce09                	beqz	a2,10c <memset+0x20>
  f4:	87aa                	mv	a5,a0
  f6:	fff6071b          	addiw	a4,a2,-1
  fa:	1702                	slli	a4,a4,0x20
  fc:	9301                	srli	a4,a4,0x20
  fe:	0705                	addi	a4,a4,1
 100:	972a                	add	a4,a4,a0
    cdst[i] = c;
 102:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 106:	0785                	addi	a5,a5,1
 108:	fee79de3          	bne	a5,a4,102 <memset+0x16>
  }
  return dst;
}
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	addi	sp,sp,16
 110:	8082                	ret

0000000000000112 <strchr>:

char*
strchr(const char *s, char c)
{
 112:	1141                	addi	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	addi	s0,sp,16
  for(; *s; s++)
 118:	00054783          	lbu	a5,0(a0)
 11c:	cf91                	beqz	a5,138 <strchr+0x26>
    if(*s == c)
 11e:	00f58a63          	beq	a1,a5,132 <strchr+0x20>
  for(; *s; s++)
 122:	0505                	addi	a0,a0,1
 124:	00054783          	lbu	a5,0(a0)
 128:	c781                	beqz	a5,130 <strchr+0x1e>
    if(*s == c)
 12a:	feb79ce3          	bne	a5,a1,122 <strchr+0x10>
 12e:	a011                	j	132 <strchr+0x20>
      return (char*)s;
  return 0;
 130:	4501                	li	a0,0
}
 132:	6422                	ld	s0,8(sp)
 134:	0141                	addi	sp,sp,16
 136:	8082                	ret
  return 0;
 138:	4501                	li	a0,0
 13a:	bfe5                	j	132 <strchr+0x20>

000000000000013c <gets>:

char*
gets(char *buf, int max)
{
 13c:	711d                	addi	sp,sp,-96
 13e:	ec86                	sd	ra,88(sp)
 140:	e8a2                	sd	s0,80(sp)
 142:	e4a6                	sd	s1,72(sp)
 144:	e0ca                	sd	s2,64(sp)
 146:	fc4e                	sd	s3,56(sp)
 148:	f852                	sd	s4,48(sp)
 14a:	f456                	sd	s5,40(sp)
 14c:	f05a                	sd	s6,32(sp)
 14e:	ec5e                	sd	s7,24(sp)
 150:	1080                	addi	s0,sp,96
 152:	8baa                	mv	s7,a0
 154:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 156:	892a                	mv	s2,a0
 158:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 15a:	4aa9                	li	s5,10
 15c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 15e:	0019849b          	addiw	s1,s3,1
 162:	0344d863          	ble	s4,s1,192 <gets+0x56>
    cc = read(0, &c, 1);
 166:	4605                	li	a2,1
 168:	faf40593          	addi	a1,s0,-81
 16c:	4501                	li	a0,0
 16e:	00000097          	auipc	ra,0x0
 172:	1fa080e7          	jalr	506(ra) # 368 <read>
    if(cc < 1)
 176:	00a05e63          	blez	a0,192 <gets+0x56>
    buf[i++] = c;
 17a:	faf44783          	lbu	a5,-81(s0)
 17e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 182:	01578763          	beq	a5,s5,190 <gets+0x54>
 186:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 188:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 18a:	fd679ae3          	bne	a5,s6,15e <gets+0x22>
 18e:	a011                	j	192 <gets+0x56>
  for(i=0; i+1 < max; ){
 190:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 192:	99de                	add	s3,s3,s7
 194:	00098023          	sb	zero,0(s3)
  return buf;
}
 198:	855e                	mv	a0,s7
 19a:	60e6                	ld	ra,88(sp)
 19c:	6446                	ld	s0,80(sp)
 19e:	64a6                	ld	s1,72(sp)
 1a0:	6906                	ld	s2,64(sp)
 1a2:	79e2                	ld	s3,56(sp)
 1a4:	7a42                	ld	s4,48(sp)
 1a6:	7aa2                	ld	s5,40(sp)
 1a8:	7b02                	ld	s6,32(sp)
 1aa:	6be2                	ld	s7,24(sp)
 1ac:	6125                	addi	sp,sp,96
 1ae:	8082                	ret

00000000000001b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1b0:	1141                	addi	sp,sp,-16
 1b2:	e422                	sd	s0,8(sp)
 1b4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b6:	00054683          	lbu	a3,0(a0)
 1ba:	fd06879b          	addiw	a5,a3,-48
 1be:	0ff7f793          	andi	a5,a5,255
 1c2:	4725                	li	a4,9
 1c4:	02f76963          	bltu	a4,a5,1f6 <atoi+0x46>
 1c8:	862a                	mv	a2,a0
  n = 0;
 1ca:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1cc:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1ce:	0605                	addi	a2,a2,1
 1d0:	0025179b          	slliw	a5,a0,0x2
 1d4:	9fa9                	addw	a5,a5,a0
 1d6:	0017979b          	slliw	a5,a5,0x1
 1da:	9fb5                	addw	a5,a5,a3
 1dc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1e0:	00064683          	lbu	a3,0(a2)
 1e4:	fd06871b          	addiw	a4,a3,-48
 1e8:	0ff77713          	andi	a4,a4,255
 1ec:	fee5f1e3          	bleu	a4,a1,1ce <atoi+0x1e>
  return n;
}
 1f0:	6422                	ld	s0,8(sp)
 1f2:	0141                	addi	sp,sp,16
 1f4:	8082                	ret
  n = 0;
 1f6:	4501                	li	a0,0
 1f8:	bfe5                	j	1f0 <atoi+0x40>

00000000000001fa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1fa:	1141                	addi	sp,sp,-16
 1fc:	e422                	sd	s0,8(sp)
 1fe:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 200:	02b57663          	bleu	a1,a0,22c <memmove+0x32>
    while(n-- > 0)
 204:	02c05163          	blez	a2,226 <memmove+0x2c>
 208:	fff6079b          	addiw	a5,a2,-1
 20c:	1782                	slli	a5,a5,0x20
 20e:	9381                	srli	a5,a5,0x20
 210:	0785                	addi	a5,a5,1
 212:	97aa                	add	a5,a5,a0
  dst = vdst;
 214:	872a                	mv	a4,a0
      *dst++ = *src++;
 216:	0585                	addi	a1,a1,1
 218:	0705                	addi	a4,a4,1
 21a:	fff5c683          	lbu	a3,-1(a1)
 21e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 222:	fee79ae3          	bne	a5,a4,216 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	addi	sp,sp,16
 22a:	8082                	ret
    dst += n;
 22c:	00c50733          	add	a4,a0,a2
    src += n;
 230:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 232:	fec05ae3          	blez	a2,226 <memmove+0x2c>
 236:	fff6079b          	addiw	a5,a2,-1
 23a:	1782                	slli	a5,a5,0x20
 23c:	9381                	srli	a5,a5,0x20
 23e:	fff7c793          	not	a5,a5
 242:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 244:	15fd                	addi	a1,a1,-1
 246:	177d                	addi	a4,a4,-1
 248:	0005c683          	lbu	a3,0(a1)
 24c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 250:	fef71ae3          	bne	a4,a5,244 <memmove+0x4a>
 254:	bfc9                	j	226 <memmove+0x2c>

0000000000000256 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 256:	1141                	addi	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 25c:	ce15                	beqz	a2,298 <memcmp+0x42>
 25e:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 262:	00054783          	lbu	a5,0(a0)
 266:	0005c703          	lbu	a4,0(a1)
 26a:	02e79063          	bne	a5,a4,28a <memcmp+0x34>
 26e:	1682                	slli	a3,a3,0x20
 270:	9281                	srli	a3,a3,0x20
 272:	0685                	addi	a3,a3,1
 274:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 276:	0505                	addi	a0,a0,1
    p2++;
 278:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 27a:	00d50d63          	beq	a0,a3,294 <memcmp+0x3e>
    if (*p1 != *p2) {
 27e:	00054783          	lbu	a5,0(a0)
 282:	0005c703          	lbu	a4,0(a1)
 286:	fee788e3          	beq	a5,a4,276 <memcmp+0x20>
      return *p1 - *p2;
 28a:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  return 0;
 294:	4501                	li	a0,0
 296:	bfe5                	j	28e <memcmp+0x38>
 298:	4501                	li	a0,0
 29a:	bfd5                	j	28e <memcmp+0x38>

000000000000029c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a4:	00000097          	auipc	ra,0x0
 2a8:	f56080e7          	jalr	-170(ra) # 1fa <memmove>
}
 2ac:	60a2                	ld	ra,8(sp)
 2ae:	6402                	ld	s0,0(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <close>:

int close(int fd){
 2b4:	1101                	addi	sp,sp,-32
 2b6:	ec06                	sd	ra,24(sp)
 2b8:	e822                	sd	s0,16(sp)
 2ba:	e426                	sd	s1,8(sp)
 2bc:	1000                	addi	s0,sp,32
 2be:	84aa                	mv	s1,a0
  fflush(fd);
 2c0:	00000097          	auipc	ra,0x0
 2c4:	2da080e7          	jalr	730(ra) # 59a <fflush>
  char* buf = get_putc_buf(fd);
 2c8:	8526                	mv	a0,s1
 2ca:	00000097          	auipc	ra,0x0
 2ce:	14e080e7          	jalr	334(ra) # 418 <get_putc_buf>
  if(buf){
 2d2:	cd11                	beqz	a0,2ee <close+0x3a>
    free(buf);
 2d4:	00000097          	auipc	ra,0x0
 2d8:	548080e7          	jalr	1352(ra) # 81c <free>
    putc_buf[fd] = 0;
 2dc:	00349713          	slli	a4,s1,0x3
 2e0:	00000797          	auipc	a5,0x0
 2e4:	6d878793          	addi	a5,a5,1752 # 9b8 <putc_buf>
 2e8:	97ba                	add	a5,a5,a4
 2ea:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2ee:	8526                	mv	a0,s1
 2f0:	00000097          	auipc	ra,0x0
 2f4:	088080e7          	jalr	136(ra) # 378 <sclose>
}
 2f8:	60e2                	ld	ra,24(sp)
 2fa:	6442                	ld	s0,16(sp)
 2fc:	64a2                	ld	s1,8(sp)
 2fe:	6105                	addi	sp,sp,32
 300:	8082                	ret

0000000000000302 <stat>:
{
 302:	1101                	addi	sp,sp,-32
 304:	ec06                	sd	ra,24(sp)
 306:	e822                	sd	s0,16(sp)
 308:	e426                	sd	s1,8(sp)
 30a:	e04a                	sd	s2,0(sp)
 30c:	1000                	addi	s0,sp,32
 30e:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 310:	4581                	li	a1,0
 312:	00000097          	auipc	ra,0x0
 316:	07e080e7          	jalr	126(ra) # 390 <open>
  if(fd < 0)
 31a:	02054563          	bltz	a0,344 <stat+0x42>
 31e:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 320:	85ca                	mv	a1,s2
 322:	00000097          	auipc	ra,0x0
 326:	086080e7          	jalr	134(ra) # 3a8 <fstat>
 32a:	892a                	mv	s2,a0
  close(fd);
 32c:	8526                	mv	a0,s1
 32e:	00000097          	auipc	ra,0x0
 332:	f86080e7          	jalr	-122(ra) # 2b4 <close>
}
 336:	854a                	mv	a0,s2
 338:	60e2                	ld	ra,24(sp)
 33a:	6442                	ld	s0,16(sp)
 33c:	64a2                	ld	s1,8(sp)
 33e:	6902                	ld	s2,0(sp)
 340:	6105                	addi	sp,sp,32
 342:	8082                	ret
    return -1;
 344:	597d                	li	s2,-1
 346:	bfc5                	j	336 <stat+0x34>

0000000000000348 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 348:	4885                	li	a7,1
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <exit>:
.global exit
exit:
 li a7, SYS_exit
 350:	4889                	li	a7,2
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <wait>:
.global wait
wait:
 li a7, SYS_wait
 358:	488d                	li	a7,3
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 360:	4891                	li	a7,4
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <read>:
.global read
read:
 li a7, SYS_read
 368:	4895                	li	a7,5
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <write>:
.global write
write:
 li a7, SYS_write
 370:	48c1                	li	a7,16
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 378:	48d5                	li	a7,21
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <kill>:
.global kill
kill:
 li a7, SYS_kill
 380:	4899                	li	a7,6
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <exec>:
.global exec
exec:
 li a7, SYS_exec
 388:	489d                	li	a7,7
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <open>:
.global open
open:
 li a7, SYS_open
 390:	48bd                	li	a7,15
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 398:	48c5                	li	a7,17
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a0:	48c9                	li	a7,18
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3a8:	48a1                	li	a7,8
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <link>:
.global link
link:
 li a7, SYS_link
 3b0:	48cd                	li	a7,19
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3b8:	48d1                	li	a7,20
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c0:	48a5                	li	a7,9
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3c8:	48a9                	li	a7,10
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d0:	48ad                	li	a7,11
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3d8:	48b1                	li	a7,12
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3e0:	48b5                	li	a7,13
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3e8:	48b9                	li	a7,14
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3f0:	48d9                	li	a7,22
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <nice>:
.global nice
nice:
 li a7, SYS_nice
 3f8:	48dd                	li	a7,23
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 400:	48e1                	li	a7,24
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 408:	48e5                	li	a7,25
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 410:	48e9                	li	a7,26
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 418:	1101                	addi	sp,sp,-32
 41a:	ec06                	sd	ra,24(sp)
 41c:	e822                	sd	s0,16(sp)
 41e:	e426                	sd	s1,8(sp)
 420:	1000                	addi	s0,sp,32
 422:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 424:	00351693          	slli	a3,a0,0x3
 428:	00000797          	auipc	a5,0x0
 42c:	59078793          	addi	a5,a5,1424 # 9b8 <putc_buf>
 430:	97b6                	add	a5,a5,a3
 432:	6388                	ld	a0,0(a5)
  if(buf) {
 434:	c511                	beqz	a0,440 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 436:	60e2                	ld	ra,24(sp)
 438:	6442                	ld	s0,16(sp)
 43a:	64a2                	ld	s1,8(sp)
 43c:	6105                	addi	sp,sp,32
 43e:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 440:	6505                	lui	a0,0x1
 442:	00000097          	auipc	ra,0x0
 446:	464080e7          	jalr	1124(ra) # 8a6 <malloc>
  putc_buf[fd] = buf;
 44a:	00000797          	auipc	a5,0x0
 44e:	56e78793          	addi	a5,a5,1390 # 9b8 <putc_buf>
 452:	00349713          	slli	a4,s1,0x3
 456:	973e                	add	a4,a4,a5
 458:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 45a:	00249713          	slli	a4,s1,0x2
 45e:	973e                	add	a4,a4,a5
 460:	32072023          	sw	zero,800(a4)
  return buf;
 464:	bfc9                	j	436 <get_putc_buf+0x1e>

0000000000000466 <putc>:

static void
putc(int fd, char c)
{
 466:	1101                	addi	sp,sp,-32
 468:	ec06                	sd	ra,24(sp)
 46a:	e822                	sd	s0,16(sp)
 46c:	e426                	sd	s1,8(sp)
 46e:	e04a                	sd	s2,0(sp)
 470:	1000                	addi	s0,sp,32
 472:	84aa                	mv	s1,a0
 474:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 476:	00000097          	auipc	ra,0x0
 47a:	fa2080e7          	jalr	-94(ra) # 418 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 47e:	00249793          	slli	a5,s1,0x2
 482:	00000717          	auipc	a4,0x0
 486:	53670713          	addi	a4,a4,1334 # 9b8 <putc_buf>
 48a:	973e                	add	a4,a4,a5
 48c:	32072783          	lw	a5,800(a4)
 490:	0017869b          	addiw	a3,a5,1
 494:	32d72023          	sw	a3,800(a4)
 498:	97aa                	add	a5,a5,a0
 49a:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 49e:	47a9                	li	a5,10
 4a0:	02f90463          	beq	s2,a5,4c8 <putc+0x62>
 4a4:	00249713          	slli	a4,s1,0x2
 4a8:	00000797          	auipc	a5,0x0
 4ac:	51078793          	addi	a5,a5,1296 # 9b8 <putc_buf>
 4b0:	97ba                	add	a5,a5,a4
 4b2:	3207a703          	lw	a4,800(a5)
 4b6:	6785                	lui	a5,0x1
 4b8:	00f70863          	beq	a4,a5,4c8 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4bc:	60e2                	ld	ra,24(sp)
 4be:	6442                	ld	s0,16(sp)
 4c0:	64a2                	ld	s1,8(sp)
 4c2:	6902                	ld	s2,0(sp)
 4c4:	6105                	addi	sp,sp,32
 4c6:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4c8:	00249793          	slli	a5,s1,0x2
 4cc:	00000917          	auipc	s2,0x0
 4d0:	4ec90913          	addi	s2,s2,1260 # 9b8 <putc_buf>
 4d4:	993e                	add	s2,s2,a5
 4d6:	32092603          	lw	a2,800(s2)
 4da:	85aa                	mv	a1,a0
 4dc:	8526                	mv	a0,s1
 4de:	00000097          	auipc	ra,0x0
 4e2:	e92080e7          	jalr	-366(ra) # 370 <write>
    putc_index[fd] = 0;
 4e6:	32092023          	sw	zero,800(s2)
}
 4ea:	bfc9                	j	4bc <putc+0x56>

00000000000004ec <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ec:	7139                	addi	sp,sp,-64
 4ee:	fc06                	sd	ra,56(sp)
 4f0:	f822                	sd	s0,48(sp)
 4f2:	f426                	sd	s1,40(sp)
 4f4:	f04a                	sd	s2,32(sp)
 4f6:	ec4e                	sd	s3,24(sp)
 4f8:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4fa:	c299                	beqz	a3,500 <printint+0x14>
 4fc:	0005cd63          	bltz	a1,516 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 500:	2581                	sext.w	a1,a1
  neg = 0;
 502:	4301                	li	t1,0
 504:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 508:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 50a:	2601                	sext.w	a2,a2
 50c:	00000897          	auipc	a7,0x0
 510:	48488893          	addi	a7,a7,1156 # 990 <digits>
 514:	a801                	j	524 <printint+0x38>
    x = -xx;
 516:	40b005bb          	negw	a1,a1
 51a:	2581                	sext.w	a1,a1
    neg = 1;
 51c:	4305                	li	t1,1
    x = -xx;
 51e:	b7dd                	j	504 <printint+0x18>
  }while((x /= base) != 0);
 520:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 522:	8836                	mv	a6,a3
 524:	0018069b          	addiw	a3,a6,1
 528:	02c5f7bb          	remuw	a5,a1,a2
 52c:	1782                	slli	a5,a5,0x20
 52e:	9381                	srli	a5,a5,0x20
 530:	97c6                	add	a5,a5,a7
 532:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x188>
 536:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 53a:	0705                	addi	a4,a4,1
 53c:	02c5d7bb          	divuw	a5,a1,a2
 540:	fec5f0e3          	bleu	a2,a1,520 <printint+0x34>
  if(neg)
 544:	00030b63          	beqz	t1,55a <printint+0x6e>
    buf[i++] = '-';
 548:	fd040793          	addi	a5,s0,-48
 54c:	96be                	add	a3,a3,a5
 54e:	02d00793          	li	a5,45
 552:	fef68823          	sb	a5,-16(a3)
 556:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 55a:	02d05963          	blez	a3,58c <printint+0xa0>
 55e:	89aa                	mv	s3,a0
 560:	fc040793          	addi	a5,s0,-64
 564:	00d784b3          	add	s1,a5,a3
 568:	fff78913          	addi	s2,a5,-1
 56c:	9936                	add	s2,s2,a3
 56e:	36fd                	addiw	a3,a3,-1
 570:	1682                	slli	a3,a3,0x20
 572:	9281                	srli	a3,a3,0x20
 574:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 578:	fff4c583          	lbu	a1,-1(s1)
 57c:	854e                	mv	a0,s3
 57e:	00000097          	auipc	ra,0x0
 582:	ee8080e7          	jalr	-280(ra) # 466 <putc>
  while(--i >= 0)
 586:	14fd                	addi	s1,s1,-1
 588:	ff2498e3          	bne	s1,s2,578 <printint+0x8c>
}
 58c:	70e2                	ld	ra,56(sp)
 58e:	7442                	ld	s0,48(sp)
 590:	74a2                	ld	s1,40(sp)
 592:	7902                	ld	s2,32(sp)
 594:	69e2                	ld	s3,24(sp)
 596:	6121                	addi	sp,sp,64
 598:	8082                	ret

000000000000059a <fflush>:
void fflush(int fd){
 59a:	1101                	addi	sp,sp,-32
 59c:	ec06                	sd	ra,24(sp)
 59e:	e822                	sd	s0,16(sp)
 5a0:	e426                	sd	s1,8(sp)
 5a2:	e04a                	sd	s2,0(sp)
 5a4:	1000                	addi	s0,sp,32
 5a6:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 5a8:	00000097          	auipc	ra,0x0
 5ac:	e70080e7          	jalr	-400(ra) # 418 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 5b0:	00291793          	slli	a5,s2,0x2
 5b4:	00000497          	auipc	s1,0x0
 5b8:	40448493          	addi	s1,s1,1028 # 9b8 <putc_buf>
 5bc:	94be                	add	s1,s1,a5
 5be:	3204a603          	lw	a2,800(s1)
 5c2:	85aa                	mv	a1,a0
 5c4:	854a                	mv	a0,s2
 5c6:	00000097          	auipc	ra,0x0
 5ca:	daa080e7          	jalr	-598(ra) # 370 <write>
  putc_index[fd] = 0;
 5ce:	3204a023          	sw	zero,800(s1)
}
 5d2:	60e2                	ld	ra,24(sp)
 5d4:	6442                	ld	s0,16(sp)
 5d6:	64a2                	ld	s1,8(sp)
 5d8:	6902                	ld	s2,0(sp)
 5da:	6105                	addi	sp,sp,32
 5dc:	8082                	ret

00000000000005de <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5de:	7119                	addi	sp,sp,-128
 5e0:	fc86                	sd	ra,120(sp)
 5e2:	f8a2                	sd	s0,112(sp)
 5e4:	f4a6                	sd	s1,104(sp)
 5e6:	f0ca                	sd	s2,96(sp)
 5e8:	ecce                	sd	s3,88(sp)
 5ea:	e8d2                	sd	s4,80(sp)
 5ec:	e4d6                	sd	s5,72(sp)
 5ee:	e0da                	sd	s6,64(sp)
 5f0:	fc5e                	sd	s7,56(sp)
 5f2:	f862                	sd	s8,48(sp)
 5f4:	f466                	sd	s9,40(sp)
 5f6:	f06a                	sd	s10,32(sp)
 5f8:	ec6e                	sd	s11,24(sp)
 5fa:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5fc:	0005c483          	lbu	s1,0(a1)
 600:	18048d63          	beqz	s1,79a <vprintf+0x1bc>
 604:	8aaa                	mv	s5,a0
 606:	8b32                	mv	s6,a2
 608:	00158913          	addi	s2,a1,1
  state = 0;
 60c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 60e:	02500a13          	li	s4,37
      if(c == 'd'){
 612:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 616:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 61a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 61e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 622:	00000b97          	auipc	s7,0x0
 626:	36eb8b93          	addi	s7,s7,878 # 990 <digits>
 62a:	a839                	j	648 <vprintf+0x6a>
        putc(fd, c);
 62c:	85a6                	mv	a1,s1
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	e36080e7          	jalr	-458(ra) # 466 <putc>
 638:	a019                	j	63e <vprintf+0x60>
    } else if(state == '%'){
 63a:	01498f63          	beq	s3,s4,658 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 63e:	0905                	addi	s2,s2,1
 640:	fff94483          	lbu	s1,-1(s2)
 644:	14048b63          	beqz	s1,79a <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 648:	0004879b          	sext.w	a5,s1
    if(state == 0){
 64c:	fe0997e3          	bnez	s3,63a <vprintf+0x5c>
      if(c == '%'){
 650:	fd479ee3          	bne	a5,s4,62c <vprintf+0x4e>
        state = '%';
 654:	89be                	mv	s3,a5
 656:	b7e5                	j	63e <vprintf+0x60>
      if(c == 'd'){
 658:	05878063          	beq	a5,s8,698 <vprintf+0xba>
      } else if(c == 'l') {
 65c:	05978c63          	beq	a5,s9,6b4 <vprintf+0xd6>
      } else if(c == 'x') {
 660:	07a78863          	beq	a5,s10,6d0 <vprintf+0xf2>
      } else if(c == 'p') {
 664:	09b78463          	beq	a5,s11,6ec <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 668:	07300713          	li	a4,115
 66c:	0ce78563          	beq	a5,a4,736 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 670:	06300713          	li	a4,99
 674:	0ee78c63          	beq	a5,a4,76c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 678:	11478663          	beq	a5,s4,784 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 67c:	85d2                	mv	a1,s4
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	de6080e7          	jalr	-538(ra) # 466 <putc>
        putc(fd, c);
 688:	85a6                	mv	a1,s1
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	dda080e7          	jalr	-550(ra) # 466 <putc>
      }
      state = 0;
 694:	4981                	li	s3,0
 696:	b765                	j	63e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 698:	008b0493          	addi	s1,s6,8
 69c:	4685                	li	a3,1
 69e:	4629                	li	a2,10
 6a0:	000b2583          	lw	a1,0(s6)
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e46080e7          	jalr	-442(ra) # 4ec <printint>
 6ae:	8b26                	mv	s6,s1
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	b771                	j	63e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b4:	008b0493          	addi	s1,s6,8
 6b8:	4681                	li	a3,0
 6ba:	4629                	li	a2,10
 6bc:	000b2583          	lw	a1,0(s6)
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	e2a080e7          	jalr	-470(ra) # 4ec <printint>
 6ca:	8b26                	mv	s6,s1
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	bf85                	j	63e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6d0:	008b0493          	addi	s1,s6,8
 6d4:	4681                	li	a3,0
 6d6:	4641                	li	a2,16
 6d8:	000b2583          	lw	a1,0(s6)
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	e0e080e7          	jalr	-498(ra) # 4ec <printint>
 6e6:	8b26                	mv	s6,s1
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	bf91                	j	63e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6ec:	008b0793          	addi	a5,s6,8
 6f0:	f8f43423          	sd	a5,-120(s0)
 6f4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6f8:	03000593          	li	a1,48
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	d68080e7          	jalr	-664(ra) # 466 <putc>
  putc(fd, 'x');
 706:	85ea                	mv	a1,s10
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	d5c080e7          	jalr	-676(ra) # 466 <putc>
 712:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 714:	03c9d793          	srli	a5,s3,0x3c
 718:	97de                	add	a5,a5,s7
 71a:	0007c583          	lbu	a1,0(a5)
 71e:	8556                	mv	a0,s5
 720:	00000097          	auipc	ra,0x0
 724:	d46080e7          	jalr	-698(ra) # 466 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 728:	0992                	slli	s3,s3,0x4
 72a:	34fd                	addiw	s1,s1,-1
 72c:	f4e5                	bnez	s1,714 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 72e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 732:	4981                	li	s3,0
 734:	b729                	j	63e <vprintf+0x60>
        s = va_arg(ap, char*);
 736:	008b0993          	addi	s3,s6,8
 73a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 73e:	c085                	beqz	s1,75e <vprintf+0x180>
        while(*s != 0){
 740:	0004c583          	lbu	a1,0(s1)
 744:	c9a1                	beqz	a1,794 <vprintf+0x1b6>
          putc(fd, *s);
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	d1e080e7          	jalr	-738(ra) # 466 <putc>
          s++;
 750:	0485                	addi	s1,s1,1
        while(*s != 0){
 752:	0004c583          	lbu	a1,0(s1)
 756:	f9e5                	bnez	a1,746 <vprintf+0x168>
        s = va_arg(ap, char*);
 758:	8b4e                	mv	s6,s3
      state = 0;
 75a:	4981                	li	s3,0
 75c:	b5cd                	j	63e <vprintf+0x60>
          s = "(null)";
 75e:	00000497          	auipc	s1,0x0
 762:	24a48493          	addi	s1,s1,586 # 9a8 <digits+0x18>
        while(*s != 0){
 766:	02800593          	li	a1,40
 76a:	bff1                	j	746 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 76c:	008b0493          	addi	s1,s6,8
 770:	000b4583          	lbu	a1,0(s6)
 774:	8556                	mv	a0,s5
 776:	00000097          	auipc	ra,0x0
 77a:	cf0080e7          	jalr	-784(ra) # 466 <putc>
 77e:	8b26                	mv	s6,s1
      state = 0;
 780:	4981                	li	s3,0
 782:	bd75                	j	63e <vprintf+0x60>
        putc(fd, c);
 784:	85d2                	mv	a1,s4
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	cde080e7          	jalr	-802(ra) # 466 <putc>
      state = 0;
 790:	4981                	li	s3,0
 792:	b575                	j	63e <vprintf+0x60>
        s = va_arg(ap, char*);
 794:	8b4e                	mv	s6,s3
      state = 0;
 796:	4981                	li	s3,0
 798:	b55d                	j	63e <vprintf+0x60>
    }
  }
}
 79a:	70e6                	ld	ra,120(sp)
 79c:	7446                	ld	s0,112(sp)
 79e:	74a6                	ld	s1,104(sp)
 7a0:	7906                	ld	s2,96(sp)
 7a2:	69e6                	ld	s3,88(sp)
 7a4:	6a46                	ld	s4,80(sp)
 7a6:	6aa6                	ld	s5,72(sp)
 7a8:	6b06                	ld	s6,64(sp)
 7aa:	7be2                	ld	s7,56(sp)
 7ac:	7c42                	ld	s8,48(sp)
 7ae:	7ca2                	ld	s9,40(sp)
 7b0:	7d02                	ld	s10,32(sp)
 7b2:	6de2                	ld	s11,24(sp)
 7b4:	6109                	addi	sp,sp,128
 7b6:	8082                	ret

00000000000007b8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7b8:	715d                	addi	sp,sp,-80
 7ba:	ec06                	sd	ra,24(sp)
 7bc:	e822                	sd	s0,16(sp)
 7be:	1000                	addi	s0,sp,32
 7c0:	e010                	sd	a2,0(s0)
 7c2:	e414                	sd	a3,8(s0)
 7c4:	e818                	sd	a4,16(s0)
 7c6:	ec1c                	sd	a5,24(s0)
 7c8:	03043023          	sd	a6,32(s0)
 7cc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d4:	8622                	mv	a2,s0
 7d6:	00000097          	auipc	ra,0x0
 7da:	e08080e7          	jalr	-504(ra) # 5de <vprintf>
}
 7de:	60e2                	ld	ra,24(sp)
 7e0:	6442                	ld	s0,16(sp)
 7e2:	6161                	addi	sp,sp,80
 7e4:	8082                	ret

00000000000007e6 <printf>:

void
printf(const char *fmt, ...)
{
 7e6:	711d                	addi	sp,sp,-96
 7e8:	ec06                	sd	ra,24(sp)
 7ea:	e822                	sd	s0,16(sp)
 7ec:	1000                	addi	s0,sp,32
 7ee:	e40c                	sd	a1,8(s0)
 7f0:	e810                	sd	a2,16(s0)
 7f2:	ec14                	sd	a3,24(s0)
 7f4:	f018                	sd	a4,32(s0)
 7f6:	f41c                	sd	a5,40(s0)
 7f8:	03043823          	sd	a6,48(s0)
 7fc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 800:	00840613          	addi	a2,s0,8
 804:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 808:	85aa                	mv	a1,a0
 80a:	4505                	li	a0,1
 80c:	00000097          	auipc	ra,0x0
 810:	dd2080e7          	jalr	-558(ra) # 5de <vprintf>
}
 814:	60e2                	ld	ra,24(sp)
 816:	6442                	ld	s0,16(sp)
 818:	6125                	addi	sp,sp,96
 81a:	8082                	ret

000000000000081c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 81c:	1141                	addi	sp,sp,-16
 81e:	e422                	sd	s0,8(sp)
 820:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 822:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x178>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 826:	00000797          	auipc	a5,0x0
 82a:	18a78793          	addi	a5,a5,394 # 9b0 <__bss_start>
 82e:	639c                	ld	a5,0(a5)
 830:	a805                	j	860 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 832:	4618                	lw	a4,8(a2)
 834:	9db9                	addw	a1,a1,a4
 836:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 83a:	6398                	ld	a4,0(a5)
 83c:	6318                	ld	a4,0(a4)
 83e:	fee53823          	sd	a4,-16(a0)
 842:	a091                	j	886 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 844:	ff852703          	lw	a4,-8(a0)
 848:	9e39                	addw	a2,a2,a4
 84a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 84c:	ff053703          	ld	a4,-16(a0)
 850:	e398                	sd	a4,0(a5)
 852:	a099                	j	898 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 854:	6398                	ld	a4,0(a5)
 856:	00e7e463          	bltu	a5,a4,85e <free+0x42>
 85a:	00e6ea63          	bltu	a3,a4,86e <free+0x52>
{
 85e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 860:	fed7fae3          	bleu	a3,a5,854 <free+0x38>
 864:	6398                	ld	a4,0(a5)
 866:	00e6e463          	bltu	a3,a4,86e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86a:	fee7eae3          	bltu	a5,a4,85e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 86e:	ff852583          	lw	a1,-8(a0)
 872:	6390                	ld	a2,0(a5)
 874:	02059713          	slli	a4,a1,0x20
 878:	9301                	srli	a4,a4,0x20
 87a:	0712                	slli	a4,a4,0x4
 87c:	9736                	add	a4,a4,a3
 87e:	fae60ae3          	beq	a2,a4,832 <free+0x16>
    bp->s.ptr = p->s.ptr;
 882:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 886:	4790                	lw	a2,8(a5)
 888:	02061713          	slli	a4,a2,0x20
 88c:	9301                	srli	a4,a4,0x20
 88e:	0712                	slli	a4,a4,0x4
 890:	973e                	add	a4,a4,a5
 892:	fae689e3          	beq	a3,a4,844 <free+0x28>
  } else
    p->s.ptr = bp;
 896:	e394                	sd	a3,0(a5)
  freep = p;
 898:	00000717          	auipc	a4,0x0
 89c:	10f73c23          	sd	a5,280(a4) # 9b0 <__bss_start>
}
 8a0:	6422                	ld	s0,8(sp)
 8a2:	0141                	addi	sp,sp,16
 8a4:	8082                	ret

00000000000008a6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a6:	7139                	addi	sp,sp,-64
 8a8:	fc06                	sd	ra,56(sp)
 8aa:	f822                	sd	s0,48(sp)
 8ac:	f426                	sd	s1,40(sp)
 8ae:	f04a                	sd	s2,32(sp)
 8b0:	ec4e                	sd	s3,24(sp)
 8b2:	e852                	sd	s4,16(sp)
 8b4:	e456                	sd	s5,8(sp)
 8b6:	e05a                	sd	s6,0(sp)
 8b8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ba:	02051993          	slli	s3,a0,0x20
 8be:	0209d993          	srli	s3,s3,0x20
 8c2:	09bd                	addi	s3,s3,15
 8c4:	0049d993          	srli	s3,s3,0x4
 8c8:	2985                	addiw	s3,s3,1
 8ca:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8ce:	00000797          	auipc	a5,0x0
 8d2:	0e278793          	addi	a5,a5,226 # 9b0 <__bss_start>
 8d6:	6388                	ld	a0,0(a5)
 8d8:	c515                	beqz	a0,904 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8da:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8dc:	4798                	lw	a4,8(a5)
 8de:	03277f63          	bleu	s2,a4,91c <malloc+0x76>
 8e2:	8a4e                	mv	s4,s3
 8e4:	0009871b          	sext.w	a4,s3
 8e8:	6685                	lui	a3,0x1
 8ea:	00d77363          	bleu	a3,a4,8f0 <malloc+0x4a>
 8ee:	6a05                	lui	s4,0x1
 8f0:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8f4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f8:	00000497          	auipc	s1,0x0
 8fc:	0b848493          	addi	s1,s1,184 # 9b0 <__bss_start>
  if(p == (char*)-1)
 900:	5b7d                	li	s6,-1
 902:	a885                	j	972 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 904:	00000797          	auipc	a5,0x0
 908:	56478793          	addi	a5,a5,1380 # e68 <base>
 90c:	00000717          	auipc	a4,0x0
 910:	0af73223          	sd	a5,164(a4) # 9b0 <__bss_start>
 914:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 916:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 91a:	b7e1                	j	8e2 <malloc+0x3c>
      if(p->s.size == nunits)
 91c:	02e90b63          	beq	s2,a4,952 <malloc+0xac>
        p->s.size -= nunits;
 920:	4137073b          	subw	a4,a4,s3
 924:	c798                	sw	a4,8(a5)
        p += p->s.size;
 926:	1702                	slli	a4,a4,0x20
 928:	9301                	srli	a4,a4,0x20
 92a:	0712                	slli	a4,a4,0x4
 92c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 92e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 932:	00000717          	auipc	a4,0x0
 936:	06a73f23          	sd	a0,126(a4) # 9b0 <__bss_start>
      return (void*)(p + 1);
 93a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 93e:	70e2                	ld	ra,56(sp)
 940:	7442                	ld	s0,48(sp)
 942:	74a2                	ld	s1,40(sp)
 944:	7902                	ld	s2,32(sp)
 946:	69e2                	ld	s3,24(sp)
 948:	6a42                	ld	s4,16(sp)
 94a:	6aa2                	ld	s5,8(sp)
 94c:	6b02                	ld	s6,0(sp)
 94e:	6121                	addi	sp,sp,64
 950:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 952:	6398                	ld	a4,0(a5)
 954:	e118                	sd	a4,0(a0)
 956:	bff1                	j	932 <malloc+0x8c>
  hp->s.size = nu;
 958:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 95c:	0541                	addi	a0,a0,16
 95e:	00000097          	auipc	ra,0x0
 962:	ebe080e7          	jalr	-322(ra) # 81c <free>
  return freep;
 966:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 968:	d979                	beqz	a0,93e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96c:	4798                	lw	a4,8(a5)
 96e:	fb2777e3          	bleu	s2,a4,91c <malloc+0x76>
    if(p == freep)
 972:	6098                	ld	a4,0(s1)
 974:	853e                	mv	a0,a5
 976:	fef71ae3          	bne	a4,a5,96a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 97a:	8552                	mv	a0,s4
 97c:	00000097          	auipc	ra,0x0
 980:	a5c080e7          	jalr	-1444(ra) # 3d8 <sbrk>
  if(p == (char*)-1)
 984:	fd651ae3          	bne	a0,s6,958 <malloc+0xb2>
        return 0;
 988:	4501                	li	a0,0
 98a:	bf55                	j	93e <malloc+0x98>
