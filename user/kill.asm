
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7dd63          	ble	a0,a5,48 <main+0x48>
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	1902                	slli	s2,s2,0x20
  1c:	02095913          	srli	s2,s2,0x20
  20:	090e                	slli	s2,s2,0x3
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	17a080e7          	jalr	378(ra) # 1a2 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	342080e7          	jalr	834(ra) # 372 <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	302080e7          	jalr	770(ra) # 342 <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	93858593          	addi	a1,a1,-1736 # 980 <malloc+0xe8>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	758080e7          	jalr	1880(ra) # 7aa <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2e6080e7          	jalr	742(ra) # 342 <exit>

0000000000000064 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0x8>
    ;
  return os;
}
  7a:	6422                	ld	s0,8(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	1141                	addi	sp,sp,-16
  82:	e422                	sd	s0,8(sp)
  84:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  86:	00054783          	lbu	a5,0(a0)
  8a:	cf91                	beqz	a5,a6 <strcmp+0x26>
  8c:	0005c703          	lbu	a4,0(a1)
  90:	00f71b63          	bne	a4,a5,a6 <strcmp+0x26>
    p++, q++;
  94:	0505                	addi	a0,a0,1
  96:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	c789                	beqz	a5,a6 <strcmp+0x26>
  9e:	0005c703          	lbu	a4,0(a1)
  a2:	fef709e3          	beq	a4,a5,94 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a6:	0005c503          	lbu	a0,0(a1)
}
  aa:	40a7853b          	subw	a0,a5,a0
  ae:	6422                	ld	s0,8(sp)
  b0:	0141                	addi	sp,sp,16
  b2:	8082                	ret

00000000000000b4 <strlen>:

uint
strlen(const char *s)
{
  b4:	1141                	addi	sp,sp,-16
  b6:	e422                	sd	s0,8(sp)
  b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ba:	00054783          	lbu	a5,0(a0)
  be:	cf91                	beqz	a5,da <strlen+0x26>
  c0:	0505                	addi	a0,a0,1
  c2:	87aa                	mv	a5,a0
  c4:	4685                	li	a3,1
  c6:	9e89                	subw	a3,a3,a0
  c8:	00f6853b          	addw	a0,a3,a5
  cc:	0785                	addi	a5,a5,1
  ce:	fff7c703          	lbu	a4,-1(a5)
  d2:	fb7d                	bnez	a4,c8 <strlen+0x14>
    ;
  return n;
}
  d4:	6422                	ld	s0,8(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret
  for(n = 0; s[n]; n++)
  da:	4501                	li	a0,0
  dc:	bfe5                	j	d4 <strlen+0x20>

00000000000000de <memset>:

void*
memset(void *dst, int c, uint n)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e422                	sd	s0,8(sp)
  e2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e4:	ce09                	beqz	a2,fe <memset+0x20>
  e6:	87aa                	mv	a5,a0
  e8:	fff6071b          	addiw	a4,a2,-1
  ec:	1702                	slli	a4,a4,0x20
  ee:	9301                	srli	a4,a4,0x20
  f0:	0705                	addi	a4,a4,1
  f2:	972a                	add	a4,a4,a0
    cdst[i] = c;
  f4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f8:	0785                	addi	a5,a5,1
  fa:	fee79de3          	bne	a5,a4,f4 <memset+0x16>
  }
  return dst;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strchr>:

char*
strchr(const char *s, char c)
{
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cf91                	beqz	a5,12a <strchr+0x26>
    if(*s == c)
 110:	00f58a63          	beq	a1,a5,124 <strchr+0x20>
  for(; *s; s++)
 114:	0505                	addi	a0,a0,1
 116:	00054783          	lbu	a5,0(a0)
 11a:	c781                	beqz	a5,122 <strchr+0x1e>
    if(*s == c)
 11c:	feb79ce3          	bne	a5,a1,114 <strchr+0x10>
 120:	a011                	j	124 <strchr+0x20>
      return (char*)s;
  return 0;
 122:	4501                	li	a0,0
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret
  return 0;
 12a:	4501                	li	a0,0
 12c:	bfe5                	j	124 <strchr+0x20>

000000000000012e <gets>:

char*
gets(char *buf, int max)
{
 12e:	711d                	addi	sp,sp,-96
 130:	ec86                	sd	ra,88(sp)
 132:	e8a2                	sd	s0,80(sp)
 134:	e4a6                	sd	s1,72(sp)
 136:	e0ca                	sd	s2,64(sp)
 138:	fc4e                	sd	s3,56(sp)
 13a:	f852                	sd	s4,48(sp)
 13c:	f456                	sd	s5,40(sp)
 13e:	f05a                	sd	s6,32(sp)
 140:	ec5e                	sd	s7,24(sp)
 142:	1080                	addi	s0,sp,96
 144:	8baa                	mv	s7,a0
 146:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 148:	892a                	mv	s2,a0
 14a:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14c:	4aa9                	li	s5,10
 14e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 150:	0019849b          	addiw	s1,s3,1
 154:	0344d863          	ble	s4,s1,184 <gets+0x56>
    cc = read(0, &c, 1);
 158:	4605                	li	a2,1
 15a:	faf40593          	addi	a1,s0,-81
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	1fa080e7          	jalr	506(ra) # 35a <read>
    if(cc < 1)
 168:	00a05e63          	blez	a0,184 <gets+0x56>
    buf[i++] = c;
 16c:	faf44783          	lbu	a5,-81(s0)
 170:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 174:	01578763          	beq	a5,s5,182 <gets+0x54>
 178:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 17a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 17c:	fd679ae3          	bne	a5,s6,150 <gets+0x22>
 180:	a011                	j	184 <gets+0x56>
  for(i=0; i+1 < max; ){
 182:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 184:	99de                	add	s3,s3,s7
 186:	00098023          	sb	zero,0(s3)
  return buf;
}
 18a:	855e                	mv	a0,s7
 18c:	60e6                	ld	ra,88(sp)
 18e:	6446                	ld	s0,80(sp)
 190:	64a6                	ld	s1,72(sp)
 192:	6906                	ld	s2,64(sp)
 194:	79e2                	ld	s3,56(sp)
 196:	7a42                	ld	s4,48(sp)
 198:	7aa2                	ld	s5,40(sp)
 19a:	7b02                	ld	s6,32(sp)
 19c:	6be2                	ld	s7,24(sp)
 19e:	6125                	addi	sp,sp,96
 1a0:	8082                	ret

00000000000001a2 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1a2:	1141                	addi	sp,sp,-16
 1a4:	e422                	sd	s0,8(sp)
 1a6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a8:	00054683          	lbu	a3,0(a0)
 1ac:	fd06879b          	addiw	a5,a3,-48
 1b0:	0ff7f793          	andi	a5,a5,255
 1b4:	4725                	li	a4,9
 1b6:	02f76963          	bltu	a4,a5,1e8 <atoi+0x46>
 1ba:	862a                	mv	a2,a0
  n = 0;
 1bc:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1be:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1c0:	0605                	addi	a2,a2,1
 1c2:	0025179b          	slliw	a5,a0,0x2
 1c6:	9fa9                	addw	a5,a5,a0
 1c8:	0017979b          	slliw	a5,a5,0x1
 1cc:	9fb5                	addw	a5,a5,a3
 1ce:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1d2:	00064683          	lbu	a3,0(a2)
 1d6:	fd06871b          	addiw	a4,a3,-48
 1da:	0ff77713          	andi	a4,a4,255
 1de:	fee5f1e3          	bleu	a4,a1,1c0 <atoi+0x1e>
  return n;
}
 1e2:	6422                	ld	s0,8(sp)
 1e4:	0141                	addi	sp,sp,16
 1e6:	8082                	ret
  n = 0;
 1e8:	4501                	li	a0,0
 1ea:	bfe5                	j	1e2 <atoi+0x40>

00000000000001ec <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1f2:	02b57663          	bleu	a1,a0,21e <memmove+0x32>
    while(n-- > 0)
 1f6:	02c05163          	blez	a2,218 <memmove+0x2c>
 1fa:	fff6079b          	addiw	a5,a2,-1
 1fe:	1782                	slli	a5,a5,0x20
 200:	9381                	srli	a5,a5,0x20
 202:	0785                	addi	a5,a5,1
 204:	97aa                	add	a5,a5,a0
  dst = vdst;
 206:	872a                	mv	a4,a0
      *dst++ = *src++;
 208:	0585                	addi	a1,a1,1
 20a:	0705                	addi	a4,a4,1
 20c:	fff5c683          	lbu	a3,-1(a1)
 210:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 214:	fee79ae3          	bne	a5,a4,208 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 218:	6422                	ld	s0,8(sp)
 21a:	0141                	addi	sp,sp,16
 21c:	8082                	ret
    dst += n;
 21e:	00c50733          	add	a4,a0,a2
    src += n;
 222:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 224:	fec05ae3          	blez	a2,218 <memmove+0x2c>
 228:	fff6079b          	addiw	a5,a2,-1
 22c:	1782                	slli	a5,a5,0x20
 22e:	9381                	srli	a5,a5,0x20
 230:	fff7c793          	not	a5,a5
 234:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 236:	15fd                	addi	a1,a1,-1
 238:	177d                	addi	a4,a4,-1
 23a:	0005c683          	lbu	a3,0(a1)
 23e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 242:	fef71ae3          	bne	a4,a5,236 <memmove+0x4a>
 246:	bfc9                	j	218 <memmove+0x2c>

0000000000000248 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 24e:	ce15                	beqz	a2,28a <memcmp+0x42>
 250:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 254:	00054783          	lbu	a5,0(a0)
 258:	0005c703          	lbu	a4,0(a1)
 25c:	02e79063          	bne	a5,a4,27c <memcmp+0x34>
 260:	1682                	slli	a3,a3,0x20
 262:	9281                	srli	a3,a3,0x20
 264:	0685                	addi	a3,a3,1
 266:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 268:	0505                	addi	a0,a0,1
    p2++;
 26a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 26c:	00d50d63          	beq	a0,a3,286 <memcmp+0x3e>
    if (*p1 != *p2) {
 270:	00054783          	lbu	a5,0(a0)
 274:	0005c703          	lbu	a4,0(a1)
 278:	fee788e3          	beq	a5,a4,268 <memcmp+0x20>
      return *p1 - *p2;
 27c:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 280:	6422                	ld	s0,8(sp)
 282:	0141                	addi	sp,sp,16
 284:	8082                	ret
  return 0;
 286:	4501                	li	a0,0
 288:	bfe5                	j	280 <memcmp+0x38>
 28a:	4501                	li	a0,0
 28c:	bfd5                	j	280 <memcmp+0x38>

000000000000028e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 296:	00000097          	auipc	ra,0x0
 29a:	f56080e7          	jalr	-170(ra) # 1ec <memmove>
}
 29e:	60a2                	ld	ra,8(sp)
 2a0:	6402                	ld	s0,0(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <close>:

int close(int fd){
 2a6:	1101                	addi	sp,sp,-32
 2a8:	ec06                	sd	ra,24(sp)
 2aa:	e822                	sd	s0,16(sp)
 2ac:	e426                	sd	s1,8(sp)
 2ae:	1000                	addi	s0,sp,32
 2b0:	84aa                	mv	s1,a0
  fflush(fd);
 2b2:	00000097          	auipc	ra,0x0
 2b6:	2da080e7          	jalr	730(ra) # 58c <fflush>
  char* buf = get_putc_buf(fd);
 2ba:	8526                	mv	a0,s1
 2bc:	00000097          	auipc	ra,0x0
 2c0:	14e080e7          	jalr	334(ra) # 40a <get_putc_buf>
  if(buf){
 2c4:	cd11                	beqz	a0,2e0 <close+0x3a>
    free(buf);
 2c6:	00000097          	auipc	ra,0x0
 2ca:	548080e7          	jalr	1352(ra) # 80e <free>
    putc_buf[fd] = 0;
 2ce:	00349713          	slli	a4,s1,0x3
 2d2:	00000797          	auipc	a5,0x0
 2d6:	6ee78793          	addi	a5,a5,1774 # 9c0 <putc_buf>
 2da:	97ba                	add	a5,a5,a4
 2dc:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2e0:	8526                	mv	a0,s1
 2e2:	00000097          	auipc	ra,0x0
 2e6:	088080e7          	jalr	136(ra) # 36a <sclose>
}
 2ea:	60e2                	ld	ra,24(sp)
 2ec:	6442                	ld	s0,16(sp)
 2ee:	64a2                	ld	s1,8(sp)
 2f0:	6105                	addi	sp,sp,32
 2f2:	8082                	ret

00000000000002f4 <stat>:
{
 2f4:	1101                	addi	sp,sp,-32
 2f6:	ec06                	sd	ra,24(sp)
 2f8:	e822                	sd	s0,16(sp)
 2fa:	e426                	sd	s1,8(sp)
 2fc:	e04a                	sd	s2,0(sp)
 2fe:	1000                	addi	s0,sp,32
 300:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 302:	4581                	li	a1,0
 304:	00000097          	auipc	ra,0x0
 308:	07e080e7          	jalr	126(ra) # 382 <open>
  if(fd < 0)
 30c:	02054563          	bltz	a0,336 <stat+0x42>
 310:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 312:	85ca                	mv	a1,s2
 314:	00000097          	auipc	ra,0x0
 318:	086080e7          	jalr	134(ra) # 39a <fstat>
 31c:	892a                	mv	s2,a0
  close(fd);
 31e:	8526                	mv	a0,s1
 320:	00000097          	auipc	ra,0x0
 324:	f86080e7          	jalr	-122(ra) # 2a6 <close>
}
 328:	854a                	mv	a0,s2
 32a:	60e2                	ld	ra,24(sp)
 32c:	6442                	ld	s0,16(sp)
 32e:	64a2                	ld	s1,8(sp)
 330:	6902                	ld	s2,0(sp)
 332:	6105                	addi	sp,sp,32
 334:	8082                	ret
    return -1;
 336:	597d                	li	s2,-1
 338:	bfc5                	j	328 <stat+0x34>

000000000000033a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33a:	4885                	li	a7,1
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <exit>:
.global exit
exit:
 li a7, SYS_exit
 342:	4889                	li	a7,2
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <wait>:
.global wait
wait:
 li a7, SYS_wait
 34a:	488d                	li	a7,3
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 352:	4891                	li	a7,4
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <read>:
.global read
read:
 li a7, SYS_read
 35a:	4895                	li	a7,5
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <write>:
.global write
write:
 li a7, SYS_write
 362:	48c1                	li	a7,16
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 36a:	48d5                	li	a7,21
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <kill>:
.global kill
kill:
 li a7, SYS_kill
 372:	4899                	li	a7,6
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <exec>:
.global exec
exec:
 li a7, SYS_exec
 37a:	489d                	li	a7,7
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <open>:
.global open
open:
 li a7, SYS_open
 382:	48bd                	li	a7,15
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38a:	48c5                	li	a7,17
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 392:	48c9                	li	a7,18
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39a:	48a1                	li	a7,8
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <link>:
.global link
link:
 li a7, SYS_link
 3a2:	48cd                	li	a7,19
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3aa:	48d1                	li	a7,20
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b2:	48a5                	li	a7,9
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ba:	48a9                	li	a7,10
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c2:	48ad                	li	a7,11
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ca:	48b1                	li	a7,12
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d2:	48b5                	li	a7,13
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3da:	48b9                	li	a7,14
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3e2:	48d9                	li	a7,22
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <nice>:
.global nice
nice:
 li a7, SYS_nice
 3ea:	48dd                	li	a7,23
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 3f2:	48e1                	li	a7,24
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 3fa:	48e5                	li	a7,25
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 402:	48e9                	li	a7,26
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 40a:	1101                	addi	sp,sp,-32
 40c:	ec06                	sd	ra,24(sp)
 40e:	e822                	sd	s0,16(sp)
 410:	e426                	sd	s1,8(sp)
 412:	1000                	addi	s0,sp,32
 414:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 416:	00351693          	slli	a3,a0,0x3
 41a:	00000797          	auipc	a5,0x0
 41e:	5a678793          	addi	a5,a5,1446 # 9c0 <putc_buf>
 422:	97b6                	add	a5,a5,a3
 424:	6388                	ld	a0,0(a5)
  if(buf) {
 426:	c511                	beqz	a0,432 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 428:	60e2                	ld	ra,24(sp)
 42a:	6442                	ld	s0,16(sp)
 42c:	64a2                	ld	s1,8(sp)
 42e:	6105                	addi	sp,sp,32
 430:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 432:	6505                	lui	a0,0x1
 434:	00000097          	auipc	ra,0x0
 438:	464080e7          	jalr	1124(ra) # 898 <malloc>
  putc_buf[fd] = buf;
 43c:	00000797          	auipc	a5,0x0
 440:	58478793          	addi	a5,a5,1412 # 9c0 <putc_buf>
 444:	00349713          	slli	a4,s1,0x3
 448:	973e                	add	a4,a4,a5
 44a:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 44c:	00249713          	slli	a4,s1,0x2
 450:	973e                	add	a4,a4,a5
 452:	32072023          	sw	zero,800(a4)
  return buf;
 456:	bfc9                	j	428 <get_putc_buf+0x1e>

0000000000000458 <putc>:

static void
putc(int fd, char c)
{
 458:	1101                	addi	sp,sp,-32
 45a:	ec06                	sd	ra,24(sp)
 45c:	e822                	sd	s0,16(sp)
 45e:	e426                	sd	s1,8(sp)
 460:	e04a                	sd	s2,0(sp)
 462:	1000                	addi	s0,sp,32
 464:	84aa                	mv	s1,a0
 466:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 468:	00000097          	auipc	ra,0x0
 46c:	fa2080e7          	jalr	-94(ra) # 40a <get_putc_buf>
  buf[putc_index[fd]++] = c;
 470:	00249793          	slli	a5,s1,0x2
 474:	00000717          	auipc	a4,0x0
 478:	54c70713          	addi	a4,a4,1356 # 9c0 <putc_buf>
 47c:	973e                	add	a4,a4,a5
 47e:	32072783          	lw	a5,800(a4)
 482:	0017869b          	addiw	a3,a5,1
 486:	32d72023          	sw	a3,800(a4)
 48a:	97aa                	add	a5,a5,a0
 48c:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 490:	47a9                	li	a5,10
 492:	02f90463          	beq	s2,a5,4ba <putc+0x62>
 496:	00249713          	slli	a4,s1,0x2
 49a:	00000797          	auipc	a5,0x0
 49e:	52678793          	addi	a5,a5,1318 # 9c0 <putc_buf>
 4a2:	97ba                	add	a5,a5,a4
 4a4:	3207a703          	lw	a4,800(a5)
 4a8:	6785                	lui	a5,0x1
 4aa:	00f70863          	beq	a4,a5,4ba <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4ae:	60e2                	ld	ra,24(sp)
 4b0:	6442                	ld	s0,16(sp)
 4b2:	64a2                	ld	s1,8(sp)
 4b4:	6902                	ld	s2,0(sp)
 4b6:	6105                	addi	sp,sp,32
 4b8:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4ba:	00249793          	slli	a5,s1,0x2
 4be:	00000917          	auipc	s2,0x0
 4c2:	50290913          	addi	s2,s2,1282 # 9c0 <putc_buf>
 4c6:	993e                	add	s2,s2,a5
 4c8:	32092603          	lw	a2,800(s2)
 4cc:	85aa                	mv	a1,a0
 4ce:	8526                	mv	a0,s1
 4d0:	00000097          	auipc	ra,0x0
 4d4:	e92080e7          	jalr	-366(ra) # 362 <write>
    putc_index[fd] = 0;
 4d8:	32092023          	sw	zero,800(s2)
}
 4dc:	bfc9                	j	4ae <putc+0x56>

00000000000004de <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4de:	7139                	addi	sp,sp,-64
 4e0:	fc06                	sd	ra,56(sp)
 4e2:	f822                	sd	s0,48(sp)
 4e4:	f426                	sd	s1,40(sp)
 4e6:	f04a                	sd	s2,32(sp)
 4e8:	ec4e                	sd	s3,24(sp)
 4ea:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ec:	c299                	beqz	a3,4f2 <printint+0x14>
 4ee:	0005cd63          	bltz	a1,508 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f2:	2581                	sext.w	a1,a1
  neg = 0;
 4f4:	4301                	li	t1,0
 4f6:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4fa:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4fc:	2601                	sext.w	a2,a2
 4fe:	00000897          	auipc	a7,0x0
 502:	49a88893          	addi	a7,a7,1178 # 998 <digits>
 506:	a801                	j	516 <printint+0x38>
    x = -xx;
 508:	40b005bb          	negw	a1,a1
 50c:	2581                	sext.w	a1,a1
    neg = 1;
 50e:	4305                	li	t1,1
    x = -xx;
 510:	b7dd                	j	4f6 <printint+0x18>
  }while((x /= base) != 0);
 512:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 514:	8836                	mv	a6,a3
 516:	0018069b          	addiw	a3,a6,1
 51a:	02c5f7bb          	remuw	a5,a1,a2
 51e:	1782                	slli	a5,a5,0x20
 520:	9381                	srli	a5,a5,0x20
 522:	97c6                	add	a5,a5,a7
 524:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x180>
 528:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 52c:	0705                	addi	a4,a4,1
 52e:	02c5d7bb          	divuw	a5,a1,a2
 532:	fec5f0e3          	bleu	a2,a1,512 <printint+0x34>
  if(neg)
 536:	00030b63          	beqz	t1,54c <printint+0x6e>
    buf[i++] = '-';
 53a:	fd040793          	addi	a5,s0,-48
 53e:	96be                	add	a3,a3,a5
 540:	02d00793          	li	a5,45
 544:	fef68823          	sb	a5,-16(a3)
 548:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 54c:	02d05963          	blez	a3,57e <printint+0xa0>
 550:	89aa                	mv	s3,a0
 552:	fc040793          	addi	a5,s0,-64
 556:	00d784b3          	add	s1,a5,a3
 55a:	fff78913          	addi	s2,a5,-1
 55e:	9936                	add	s2,s2,a3
 560:	36fd                	addiw	a3,a3,-1
 562:	1682                	slli	a3,a3,0x20
 564:	9281                	srli	a3,a3,0x20
 566:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 56a:	fff4c583          	lbu	a1,-1(s1)
 56e:	854e                	mv	a0,s3
 570:	00000097          	auipc	ra,0x0
 574:	ee8080e7          	jalr	-280(ra) # 458 <putc>
  while(--i >= 0)
 578:	14fd                	addi	s1,s1,-1
 57a:	ff2498e3          	bne	s1,s2,56a <printint+0x8c>
}
 57e:	70e2                	ld	ra,56(sp)
 580:	7442                	ld	s0,48(sp)
 582:	74a2                	ld	s1,40(sp)
 584:	7902                	ld	s2,32(sp)
 586:	69e2                	ld	s3,24(sp)
 588:	6121                	addi	sp,sp,64
 58a:	8082                	ret

000000000000058c <fflush>:
void fflush(int fd){
 58c:	1101                	addi	sp,sp,-32
 58e:	ec06                	sd	ra,24(sp)
 590:	e822                	sd	s0,16(sp)
 592:	e426                	sd	s1,8(sp)
 594:	e04a                	sd	s2,0(sp)
 596:	1000                	addi	s0,sp,32
 598:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 59a:	00000097          	auipc	ra,0x0
 59e:	e70080e7          	jalr	-400(ra) # 40a <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 5a2:	00291793          	slli	a5,s2,0x2
 5a6:	00000497          	auipc	s1,0x0
 5aa:	41a48493          	addi	s1,s1,1050 # 9c0 <putc_buf>
 5ae:	94be                	add	s1,s1,a5
 5b0:	3204a603          	lw	a2,800(s1)
 5b4:	85aa                	mv	a1,a0
 5b6:	854a                	mv	a0,s2
 5b8:	00000097          	auipc	ra,0x0
 5bc:	daa080e7          	jalr	-598(ra) # 362 <write>
  putc_index[fd] = 0;
 5c0:	3204a023          	sw	zero,800(s1)
}
 5c4:	60e2                	ld	ra,24(sp)
 5c6:	6442                	ld	s0,16(sp)
 5c8:	64a2                	ld	s1,8(sp)
 5ca:	6902                	ld	s2,0(sp)
 5cc:	6105                	addi	sp,sp,32
 5ce:	8082                	ret

00000000000005d0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5d0:	7119                	addi	sp,sp,-128
 5d2:	fc86                	sd	ra,120(sp)
 5d4:	f8a2                	sd	s0,112(sp)
 5d6:	f4a6                	sd	s1,104(sp)
 5d8:	f0ca                	sd	s2,96(sp)
 5da:	ecce                	sd	s3,88(sp)
 5dc:	e8d2                	sd	s4,80(sp)
 5de:	e4d6                	sd	s5,72(sp)
 5e0:	e0da                	sd	s6,64(sp)
 5e2:	fc5e                	sd	s7,56(sp)
 5e4:	f862                	sd	s8,48(sp)
 5e6:	f466                	sd	s9,40(sp)
 5e8:	f06a                	sd	s10,32(sp)
 5ea:	ec6e                	sd	s11,24(sp)
 5ec:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ee:	0005c483          	lbu	s1,0(a1)
 5f2:	18048d63          	beqz	s1,78c <vprintf+0x1bc>
 5f6:	8aaa                	mv	s5,a0
 5f8:	8b32                	mv	s6,a2
 5fa:	00158913          	addi	s2,a1,1
  state = 0;
 5fe:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 600:	02500a13          	li	s4,37
      if(c == 'd'){
 604:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 608:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 60c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 610:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 614:	00000b97          	auipc	s7,0x0
 618:	384b8b93          	addi	s7,s7,900 # 998 <digits>
 61c:	a839                	j	63a <vprintf+0x6a>
        putc(fd, c);
 61e:	85a6                	mv	a1,s1
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	e36080e7          	jalr	-458(ra) # 458 <putc>
 62a:	a019                	j	630 <vprintf+0x60>
    } else if(state == '%'){
 62c:	01498f63          	beq	s3,s4,64a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 630:	0905                	addi	s2,s2,1
 632:	fff94483          	lbu	s1,-1(s2)
 636:	14048b63          	beqz	s1,78c <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 63a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 63e:	fe0997e3          	bnez	s3,62c <vprintf+0x5c>
      if(c == '%'){
 642:	fd479ee3          	bne	a5,s4,61e <vprintf+0x4e>
        state = '%';
 646:	89be                	mv	s3,a5
 648:	b7e5                	j	630 <vprintf+0x60>
      if(c == 'd'){
 64a:	05878063          	beq	a5,s8,68a <vprintf+0xba>
      } else if(c == 'l') {
 64e:	05978c63          	beq	a5,s9,6a6 <vprintf+0xd6>
      } else if(c == 'x') {
 652:	07a78863          	beq	a5,s10,6c2 <vprintf+0xf2>
      } else if(c == 'p') {
 656:	09b78463          	beq	a5,s11,6de <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 65a:	07300713          	li	a4,115
 65e:	0ce78563          	beq	a5,a4,728 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 662:	06300713          	li	a4,99
 666:	0ee78c63          	beq	a5,a4,75e <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 66a:	11478663          	beq	a5,s4,776 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 66e:	85d2                	mv	a1,s4
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	de6080e7          	jalr	-538(ra) # 458 <putc>
        putc(fd, c);
 67a:	85a6                	mv	a1,s1
 67c:	8556                	mv	a0,s5
 67e:	00000097          	auipc	ra,0x0
 682:	dda080e7          	jalr	-550(ra) # 458 <putc>
      }
      state = 0;
 686:	4981                	li	s3,0
 688:	b765                	j	630 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 68a:	008b0493          	addi	s1,s6,8
 68e:	4685                	li	a3,1
 690:	4629                	li	a2,10
 692:	000b2583          	lw	a1,0(s6)
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	e46080e7          	jalr	-442(ra) # 4de <printint>
 6a0:	8b26                	mv	s6,s1
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	b771                	j	630 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a6:	008b0493          	addi	s1,s6,8
 6aa:	4681                	li	a3,0
 6ac:	4629                	li	a2,10
 6ae:	000b2583          	lw	a1,0(s6)
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	e2a080e7          	jalr	-470(ra) # 4de <printint>
 6bc:	8b26                	mv	s6,s1
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	bf85                	j	630 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6c2:	008b0493          	addi	s1,s6,8
 6c6:	4681                	li	a3,0
 6c8:	4641                	li	a2,16
 6ca:	000b2583          	lw	a1,0(s6)
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	e0e080e7          	jalr	-498(ra) # 4de <printint>
 6d8:	8b26                	mv	s6,s1
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	bf91                	j	630 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6de:	008b0793          	addi	a5,s6,8
 6e2:	f8f43423          	sd	a5,-120(s0)
 6e6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6ea:	03000593          	li	a1,48
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	d68080e7          	jalr	-664(ra) # 458 <putc>
  putc(fd, 'x');
 6f8:	85ea                	mv	a1,s10
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	d5c080e7          	jalr	-676(ra) # 458 <putc>
 704:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 706:	03c9d793          	srli	a5,s3,0x3c
 70a:	97de                	add	a5,a5,s7
 70c:	0007c583          	lbu	a1,0(a5)
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	d46080e7          	jalr	-698(ra) # 458 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 71a:	0992                	slli	s3,s3,0x4
 71c:	34fd                	addiw	s1,s1,-1
 71e:	f4e5                	bnez	s1,706 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 720:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 724:	4981                	li	s3,0
 726:	b729                	j	630 <vprintf+0x60>
        s = va_arg(ap, char*);
 728:	008b0993          	addi	s3,s6,8
 72c:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 730:	c085                	beqz	s1,750 <vprintf+0x180>
        while(*s != 0){
 732:	0004c583          	lbu	a1,0(s1)
 736:	c9a1                	beqz	a1,786 <vprintf+0x1b6>
          putc(fd, *s);
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	d1e080e7          	jalr	-738(ra) # 458 <putc>
          s++;
 742:	0485                	addi	s1,s1,1
        while(*s != 0){
 744:	0004c583          	lbu	a1,0(s1)
 748:	f9e5                	bnez	a1,738 <vprintf+0x168>
        s = va_arg(ap, char*);
 74a:	8b4e                	mv	s6,s3
      state = 0;
 74c:	4981                	li	s3,0
 74e:	b5cd                	j	630 <vprintf+0x60>
          s = "(null)";
 750:	00000497          	auipc	s1,0x0
 754:	26048493          	addi	s1,s1,608 # 9b0 <digits+0x18>
        while(*s != 0){
 758:	02800593          	li	a1,40
 75c:	bff1                	j	738 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 75e:	008b0493          	addi	s1,s6,8
 762:	000b4583          	lbu	a1,0(s6)
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	cf0080e7          	jalr	-784(ra) # 458 <putc>
 770:	8b26                	mv	s6,s1
      state = 0;
 772:	4981                	li	s3,0
 774:	bd75                	j	630 <vprintf+0x60>
        putc(fd, c);
 776:	85d2                	mv	a1,s4
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	cde080e7          	jalr	-802(ra) # 458 <putc>
      state = 0;
 782:	4981                	li	s3,0
 784:	b575                	j	630 <vprintf+0x60>
        s = va_arg(ap, char*);
 786:	8b4e                	mv	s6,s3
      state = 0;
 788:	4981                	li	s3,0
 78a:	b55d                	j	630 <vprintf+0x60>
    }
  }
}
 78c:	70e6                	ld	ra,120(sp)
 78e:	7446                	ld	s0,112(sp)
 790:	74a6                	ld	s1,104(sp)
 792:	7906                	ld	s2,96(sp)
 794:	69e6                	ld	s3,88(sp)
 796:	6a46                	ld	s4,80(sp)
 798:	6aa6                	ld	s5,72(sp)
 79a:	6b06                	ld	s6,64(sp)
 79c:	7be2                	ld	s7,56(sp)
 79e:	7c42                	ld	s8,48(sp)
 7a0:	7ca2                	ld	s9,40(sp)
 7a2:	7d02                	ld	s10,32(sp)
 7a4:	6de2                	ld	s11,24(sp)
 7a6:	6109                	addi	sp,sp,128
 7a8:	8082                	ret

00000000000007aa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7aa:	715d                	addi	sp,sp,-80
 7ac:	ec06                	sd	ra,24(sp)
 7ae:	e822                	sd	s0,16(sp)
 7b0:	1000                	addi	s0,sp,32
 7b2:	e010                	sd	a2,0(s0)
 7b4:	e414                	sd	a3,8(s0)
 7b6:	e818                	sd	a4,16(s0)
 7b8:	ec1c                	sd	a5,24(s0)
 7ba:	03043023          	sd	a6,32(s0)
 7be:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7c2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7c6:	8622                	mv	a2,s0
 7c8:	00000097          	auipc	ra,0x0
 7cc:	e08080e7          	jalr	-504(ra) # 5d0 <vprintf>
}
 7d0:	60e2                	ld	ra,24(sp)
 7d2:	6442                	ld	s0,16(sp)
 7d4:	6161                	addi	sp,sp,80
 7d6:	8082                	ret

00000000000007d8 <printf>:

void
printf(const char *fmt, ...)
{
 7d8:	711d                	addi	sp,sp,-96
 7da:	ec06                	sd	ra,24(sp)
 7dc:	e822                	sd	s0,16(sp)
 7de:	1000                	addi	s0,sp,32
 7e0:	e40c                	sd	a1,8(s0)
 7e2:	e810                	sd	a2,16(s0)
 7e4:	ec14                	sd	a3,24(s0)
 7e6:	f018                	sd	a4,32(s0)
 7e8:	f41c                	sd	a5,40(s0)
 7ea:	03043823          	sd	a6,48(s0)
 7ee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7f2:	00840613          	addi	a2,s0,8
 7f6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7fa:	85aa                	mv	a1,a0
 7fc:	4505                	li	a0,1
 7fe:	00000097          	auipc	ra,0x0
 802:	dd2080e7          	jalr	-558(ra) # 5d0 <vprintf>
}
 806:	60e2                	ld	ra,24(sp)
 808:	6442                	ld	s0,16(sp)
 80a:	6125                	addi	sp,sp,96
 80c:	8082                	ret

000000000000080e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 80e:	1141                	addi	sp,sp,-16
 810:	e422                	sd	s0,8(sp)
 812:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 814:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x170>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 818:	00000797          	auipc	a5,0x0
 81c:	1a078793          	addi	a5,a5,416 # 9b8 <__bss_start>
 820:	639c                	ld	a5,0(a5)
 822:	a805                	j	852 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 824:	4618                	lw	a4,8(a2)
 826:	9db9                	addw	a1,a1,a4
 828:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 82c:	6398                	ld	a4,0(a5)
 82e:	6318                	ld	a4,0(a4)
 830:	fee53823          	sd	a4,-16(a0)
 834:	a091                	j	878 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 836:	ff852703          	lw	a4,-8(a0)
 83a:	9e39                	addw	a2,a2,a4
 83c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 83e:	ff053703          	ld	a4,-16(a0)
 842:	e398                	sd	a4,0(a5)
 844:	a099                	j	88a <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 846:	6398                	ld	a4,0(a5)
 848:	00e7e463          	bltu	a5,a4,850 <free+0x42>
 84c:	00e6ea63          	bltu	a3,a4,860 <free+0x52>
{
 850:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 852:	fed7fae3          	bleu	a3,a5,846 <free+0x38>
 856:	6398                	ld	a4,0(a5)
 858:	00e6e463          	bltu	a3,a4,860 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85c:	fee7eae3          	bltu	a5,a4,850 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 860:	ff852583          	lw	a1,-8(a0)
 864:	6390                	ld	a2,0(a5)
 866:	02059713          	slli	a4,a1,0x20
 86a:	9301                	srli	a4,a4,0x20
 86c:	0712                	slli	a4,a4,0x4
 86e:	9736                	add	a4,a4,a3
 870:	fae60ae3          	beq	a2,a4,824 <free+0x16>
    bp->s.ptr = p->s.ptr;
 874:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 878:	4790                	lw	a2,8(a5)
 87a:	02061713          	slli	a4,a2,0x20
 87e:	9301                	srli	a4,a4,0x20
 880:	0712                	slli	a4,a4,0x4
 882:	973e                	add	a4,a4,a5
 884:	fae689e3          	beq	a3,a4,836 <free+0x28>
  } else
    p->s.ptr = bp;
 888:	e394                	sd	a3,0(a5)
  freep = p;
 88a:	00000717          	auipc	a4,0x0
 88e:	12f73723          	sd	a5,302(a4) # 9b8 <__bss_start>
}
 892:	6422                	ld	s0,8(sp)
 894:	0141                	addi	sp,sp,16
 896:	8082                	ret

0000000000000898 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 898:	7139                	addi	sp,sp,-64
 89a:	fc06                	sd	ra,56(sp)
 89c:	f822                	sd	s0,48(sp)
 89e:	f426                	sd	s1,40(sp)
 8a0:	f04a                	sd	s2,32(sp)
 8a2:	ec4e                	sd	s3,24(sp)
 8a4:	e852                	sd	s4,16(sp)
 8a6:	e456                	sd	s5,8(sp)
 8a8:	e05a                	sd	s6,0(sp)
 8aa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ac:	02051993          	slli	s3,a0,0x20
 8b0:	0209d993          	srli	s3,s3,0x20
 8b4:	09bd                	addi	s3,s3,15
 8b6:	0049d993          	srli	s3,s3,0x4
 8ba:	2985                	addiw	s3,s3,1
 8bc:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8c0:	00000797          	auipc	a5,0x0
 8c4:	0f878793          	addi	a5,a5,248 # 9b8 <__bss_start>
 8c8:	6388                	ld	a0,0(a5)
 8ca:	c515                	beqz	a0,8f6 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ce:	4798                	lw	a4,8(a5)
 8d0:	03277f63          	bleu	s2,a4,90e <malloc+0x76>
 8d4:	8a4e                	mv	s4,s3
 8d6:	0009871b          	sext.w	a4,s3
 8da:	6685                	lui	a3,0x1
 8dc:	00d77363          	bleu	a3,a4,8e2 <malloc+0x4a>
 8e0:	6a05                	lui	s4,0x1
 8e2:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8e6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8ea:	00000497          	auipc	s1,0x0
 8ee:	0ce48493          	addi	s1,s1,206 # 9b8 <__bss_start>
  if(p == (char*)-1)
 8f2:	5b7d                	li	s6,-1
 8f4:	a885                	j	964 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8f6:	00000797          	auipc	a5,0x0
 8fa:	57a78793          	addi	a5,a5,1402 # e70 <base>
 8fe:	00000717          	auipc	a4,0x0
 902:	0af73d23          	sd	a5,186(a4) # 9b8 <__bss_start>
 906:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 908:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 90c:	b7e1                	j	8d4 <malloc+0x3c>
      if(p->s.size == nunits)
 90e:	02e90b63          	beq	s2,a4,944 <malloc+0xac>
        p->s.size -= nunits;
 912:	4137073b          	subw	a4,a4,s3
 916:	c798                	sw	a4,8(a5)
        p += p->s.size;
 918:	1702                	slli	a4,a4,0x20
 91a:	9301                	srli	a4,a4,0x20
 91c:	0712                	slli	a4,a4,0x4
 91e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 920:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 924:	00000717          	auipc	a4,0x0
 928:	08a73a23          	sd	a0,148(a4) # 9b8 <__bss_start>
      return (void*)(p + 1);
 92c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 930:	70e2                	ld	ra,56(sp)
 932:	7442                	ld	s0,48(sp)
 934:	74a2                	ld	s1,40(sp)
 936:	7902                	ld	s2,32(sp)
 938:	69e2                	ld	s3,24(sp)
 93a:	6a42                	ld	s4,16(sp)
 93c:	6aa2                	ld	s5,8(sp)
 93e:	6b02                	ld	s6,0(sp)
 940:	6121                	addi	sp,sp,64
 942:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 944:	6398                	ld	a4,0(a5)
 946:	e118                	sd	a4,0(a0)
 948:	bff1                	j	924 <malloc+0x8c>
  hp->s.size = nu;
 94a:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 94e:	0541                	addi	a0,a0,16
 950:	00000097          	auipc	ra,0x0
 954:	ebe080e7          	jalr	-322(ra) # 80e <free>
  return freep;
 958:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 95a:	d979                	beqz	a0,930 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 95c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 95e:	4798                	lw	a4,8(a5)
 960:	fb2777e3          	bleu	s2,a4,90e <malloc+0x76>
    if(p == freep)
 964:	6098                	ld	a4,0(s1)
 966:	853e                	mv	a0,a5
 968:	fef71ae3          	bne	a4,a5,95c <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 96c:	8552                	mv	a0,s4
 96e:	00000097          	auipc	ra,0x0
 972:	a5c080e7          	jalr	-1444(ra) # 3ca <sbrk>
  if(p == (char*)-1)
 976:	fd651ae3          	bne	a0,s6,94a <malloc+0xb2>
        return 0;
 97a:	4501                	li	a0,0
 97c:	bf55                	j	930 <malloc+0x98>
