
user/_mutest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main(){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  int fd = create_mutex();
   e:	00000097          	auipc	ra,0x0
  12:	424080e7          	jalr	1060(ra) # 432 <create_mutex>
  16:	89aa                	mv	s3,a0
  acquire_mutex(fd);
  18:	00000097          	auipc	ra,0x0
  1c:	422080e7          	jalr	1058(ra) # 43a <acquire_mutex>
  int pid = fork();
  20:	00000097          	auipc	ra,0x0
  24:	35a080e7          	jalr	858(ra) # 37a <fork>
  if(pid < 0){
  28:	02054f63          	bltz	a0,66 <main+0x66>
    printf("error fork\n");
    exit(1);
  } else if (pid == 0){
  2c:	3e800493          	li	s1,1000
    acquire_mutex(fd);
    printf("Oui, père.\n");
    exit(0);
  } else {
    for(int i = 0; i < 1000; i++){
      printf("Fils, tu m'attendras\n");
  30:	00001917          	auipc	s2,0x1
  34:	9b090913          	addi	s2,s2,-1616 # 9e0 <malloc+0x108>
  } else if (pid == 0){
  38:	c521                	beqz	a0,80 <main+0x80>
      printf("Fils, tu m'attendras\n");
  3a:	854a                	mv	a0,s2
  3c:	00000097          	auipc	ra,0x0
  40:	7dc080e7          	jalr	2012(ra) # 818 <printf>
    for(int i = 0; i < 1000; i++){
  44:	34fd                	addiw	s1,s1,-1
  46:	f8f5                	bnez	s1,3a <main+0x3a>
    }
    release_mutex(fd);
  48:	854e                	mv	a0,s3
  4a:	00000097          	auipc	ra,0x0
  4e:	3f8080e7          	jalr	1016(ra) # 442 <release_mutex>
    wait(0);
  52:	4501                	li	a0,0
  54:	00000097          	auipc	ra,0x0
  58:	336080e7          	jalr	822(ra) # 38a <wait>
    exit(0);
  5c:	4501                	li	a0,0
  5e:	00000097          	auipc	ra,0x0
  62:	324080e7          	jalr	804(ra) # 382 <exit>
    printf("error fork\n");
  66:	00001517          	auipc	a0,0x1
  6a:	95a50513          	addi	a0,a0,-1702 # 9c0 <malloc+0xe8>
  6e:	00000097          	auipc	ra,0x0
  72:	7aa080e7          	jalr	1962(ra) # 818 <printf>
    exit(1);
  76:	4505                	li	a0,1
  78:	00000097          	auipc	ra,0x0
  7c:	30a080e7          	jalr	778(ra) # 382 <exit>
    acquire_mutex(fd);
  80:	854e                	mv	a0,s3
  82:	00000097          	auipc	ra,0x0
  86:	3b8080e7          	jalr	952(ra) # 43a <acquire_mutex>
    printf("Oui, père.\n");
  8a:	00001517          	auipc	a0,0x1
  8e:	94650513          	addi	a0,a0,-1722 # 9d0 <malloc+0xf8>
  92:	00000097          	auipc	ra,0x0
  96:	786080e7          	jalr	1926(ra) # 818 <printf>
    exit(0);
  9a:	4501                	li	a0,0
  9c:	00000097          	auipc	ra,0x0
  a0:	2e6080e7          	jalr	742(ra) # 382 <exit>

00000000000000a4 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e422                	sd	s0,8(sp)
  a8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  aa:	87aa                	mv	a5,a0
  ac:	0585                	addi	a1,a1,1
  ae:	0785                	addi	a5,a5,1
  b0:	fff5c703          	lbu	a4,-1(a1)
  b4:	fee78fa3          	sb	a4,-1(a5)
  b8:	fb75                	bnez	a4,ac <strcpy+0x8>
    ;
  return os;
}
  ba:	6422                	ld	s0,8(sp)
  bc:	0141                	addi	sp,sp,16
  be:	8082                	ret

00000000000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	1141                	addi	sp,sp,-16
  c2:	e422                	sd	s0,8(sp)
  c4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	cf91                	beqz	a5,e6 <strcmp+0x26>
  cc:	0005c703          	lbu	a4,0(a1)
  d0:	00f71b63          	bne	a4,a5,e6 <strcmp+0x26>
    p++, q++;
  d4:	0505                	addi	a0,a0,1
  d6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d8:	00054783          	lbu	a5,0(a0)
  dc:	c789                	beqz	a5,e6 <strcmp+0x26>
  de:	0005c703          	lbu	a4,0(a1)
  e2:	fef709e3          	beq	a4,a5,d4 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  e6:	0005c503          	lbu	a0,0(a1)
}
  ea:	40a7853b          	subw	a0,a5,a0
  ee:	6422                	ld	s0,8(sp)
  f0:	0141                	addi	sp,sp,16
  f2:	8082                	ret

00000000000000f4 <strlen>:

uint
strlen(const char *s)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cf91                	beqz	a5,11a <strlen+0x26>
 100:	0505                	addi	a0,a0,1
 102:	87aa                	mv	a5,a0
 104:	4685                	li	a3,1
 106:	9e89                	subw	a3,a3,a0
 108:	00f6853b          	addw	a0,a3,a5
 10c:	0785                	addi	a5,a5,1
 10e:	fff7c703          	lbu	a4,-1(a5)
 112:	fb7d                	bnez	a4,108 <strlen+0x14>
    ;
  return n;
}
 114:	6422                	ld	s0,8(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret
  for(n = 0; s[n]; n++)
 11a:	4501                	li	a0,0
 11c:	bfe5                	j	114 <strlen+0x20>

000000000000011e <memset>:

void*
memset(void *dst, int c, uint n)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 124:	ce09                	beqz	a2,13e <memset+0x20>
 126:	87aa                	mv	a5,a0
 128:	fff6071b          	addiw	a4,a2,-1
 12c:	1702                	slli	a4,a4,0x20
 12e:	9301                	srli	a4,a4,0x20
 130:	0705                	addi	a4,a4,1
 132:	972a                	add	a4,a4,a0
    cdst[i] = c;
 134:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 138:	0785                	addi	a5,a5,1
 13a:	fee79de3          	bne	a5,a4,134 <memset+0x16>
  }
  return dst;
}
 13e:	6422                	ld	s0,8(sp)
 140:	0141                	addi	sp,sp,16
 142:	8082                	ret

0000000000000144 <strchr>:

char*
strchr(const char *s, char c)
{
 144:	1141                	addi	sp,sp,-16
 146:	e422                	sd	s0,8(sp)
 148:	0800                	addi	s0,sp,16
  for(; *s; s++)
 14a:	00054783          	lbu	a5,0(a0)
 14e:	cf91                	beqz	a5,16a <strchr+0x26>
    if(*s == c)
 150:	00f58a63          	beq	a1,a5,164 <strchr+0x20>
  for(; *s; s++)
 154:	0505                	addi	a0,a0,1
 156:	00054783          	lbu	a5,0(a0)
 15a:	c781                	beqz	a5,162 <strchr+0x1e>
    if(*s == c)
 15c:	feb79ce3          	bne	a5,a1,154 <strchr+0x10>
 160:	a011                	j	164 <strchr+0x20>
      return (char*)s;
  return 0;
 162:	4501                	li	a0,0
}
 164:	6422                	ld	s0,8(sp)
 166:	0141                	addi	sp,sp,16
 168:	8082                	ret
  return 0;
 16a:	4501                	li	a0,0
 16c:	bfe5                	j	164 <strchr+0x20>

000000000000016e <gets>:

char*
gets(char *buf, int max)
{
 16e:	711d                	addi	sp,sp,-96
 170:	ec86                	sd	ra,88(sp)
 172:	e8a2                	sd	s0,80(sp)
 174:	e4a6                	sd	s1,72(sp)
 176:	e0ca                	sd	s2,64(sp)
 178:	fc4e                	sd	s3,56(sp)
 17a:	f852                	sd	s4,48(sp)
 17c:	f456                	sd	s5,40(sp)
 17e:	f05a                	sd	s6,32(sp)
 180:	ec5e                	sd	s7,24(sp)
 182:	1080                	addi	s0,sp,96
 184:	8baa                	mv	s7,a0
 186:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 188:	892a                	mv	s2,a0
 18a:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 18c:	4aa9                	li	s5,10
 18e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 190:	0019849b          	addiw	s1,s3,1
 194:	0344d863          	ble	s4,s1,1c4 <gets+0x56>
    cc = read(0, &c, 1);
 198:	4605                	li	a2,1
 19a:	faf40593          	addi	a1,s0,-81
 19e:	4501                	li	a0,0
 1a0:	00000097          	auipc	ra,0x0
 1a4:	1fa080e7          	jalr	506(ra) # 39a <read>
    if(cc < 1)
 1a8:	00a05e63          	blez	a0,1c4 <gets+0x56>
    buf[i++] = c;
 1ac:	faf44783          	lbu	a5,-81(s0)
 1b0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1b4:	01578763          	beq	a5,s5,1c2 <gets+0x54>
 1b8:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 1ba:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 1bc:	fd679ae3          	bne	a5,s6,190 <gets+0x22>
 1c0:	a011                	j	1c4 <gets+0x56>
  for(i=0; i+1 < max; ){
 1c2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1c4:	99de                	add	s3,s3,s7
 1c6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1ca:	855e                	mv	a0,s7
 1cc:	60e6                	ld	ra,88(sp)
 1ce:	6446                	ld	s0,80(sp)
 1d0:	64a6                	ld	s1,72(sp)
 1d2:	6906                	ld	s2,64(sp)
 1d4:	79e2                	ld	s3,56(sp)
 1d6:	7a42                	ld	s4,48(sp)
 1d8:	7aa2                	ld	s5,40(sp)
 1da:	7b02                	ld	s6,32(sp)
 1dc:	6be2                	ld	s7,24(sp)
 1de:	6125                	addi	sp,sp,96
 1e0:	8082                	ret

00000000000001e2 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e422                	sd	s0,8(sp)
 1e6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e8:	00054683          	lbu	a3,0(a0)
 1ec:	fd06879b          	addiw	a5,a3,-48
 1f0:	0ff7f793          	andi	a5,a5,255
 1f4:	4725                	li	a4,9
 1f6:	02f76963          	bltu	a4,a5,228 <atoi+0x46>
 1fa:	862a                	mv	a2,a0
  n = 0;
 1fc:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1fe:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 200:	0605                	addi	a2,a2,1
 202:	0025179b          	slliw	a5,a0,0x2
 206:	9fa9                	addw	a5,a5,a0
 208:	0017979b          	slliw	a5,a5,0x1
 20c:	9fb5                	addw	a5,a5,a3
 20e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 212:	00064683          	lbu	a3,0(a2)
 216:	fd06871b          	addiw	a4,a3,-48
 21a:	0ff77713          	andi	a4,a4,255
 21e:	fee5f1e3          	bleu	a4,a1,200 <atoi+0x1e>
  return n;
}
 222:	6422                	ld	s0,8(sp)
 224:	0141                	addi	sp,sp,16
 226:	8082                	ret
  n = 0;
 228:	4501                	li	a0,0
 22a:	bfe5                	j	222 <atoi+0x40>

000000000000022c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 22c:	1141                	addi	sp,sp,-16
 22e:	e422                	sd	s0,8(sp)
 230:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 232:	02b57663          	bleu	a1,a0,25e <memmove+0x32>
    while(n-- > 0)
 236:	02c05163          	blez	a2,258 <memmove+0x2c>
 23a:	fff6079b          	addiw	a5,a2,-1
 23e:	1782                	slli	a5,a5,0x20
 240:	9381                	srli	a5,a5,0x20
 242:	0785                	addi	a5,a5,1
 244:	97aa                	add	a5,a5,a0
  dst = vdst;
 246:	872a                	mv	a4,a0
      *dst++ = *src++;
 248:	0585                	addi	a1,a1,1
 24a:	0705                	addi	a4,a4,1
 24c:	fff5c683          	lbu	a3,-1(a1)
 250:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 254:	fee79ae3          	bne	a5,a4,248 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	addi	sp,sp,16
 25c:	8082                	ret
    dst += n;
 25e:	00c50733          	add	a4,a0,a2
    src += n;
 262:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 264:	fec05ae3          	blez	a2,258 <memmove+0x2c>
 268:	fff6079b          	addiw	a5,a2,-1
 26c:	1782                	slli	a5,a5,0x20
 26e:	9381                	srli	a5,a5,0x20
 270:	fff7c793          	not	a5,a5
 274:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 276:	15fd                	addi	a1,a1,-1
 278:	177d                	addi	a4,a4,-1
 27a:	0005c683          	lbu	a3,0(a1)
 27e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 282:	fef71ae3          	bne	a4,a5,276 <memmove+0x4a>
 286:	bfc9                	j	258 <memmove+0x2c>

0000000000000288 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 28e:	ce15                	beqz	a2,2ca <memcmp+0x42>
 290:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 294:	00054783          	lbu	a5,0(a0)
 298:	0005c703          	lbu	a4,0(a1)
 29c:	02e79063          	bne	a5,a4,2bc <memcmp+0x34>
 2a0:	1682                	slli	a3,a3,0x20
 2a2:	9281                	srli	a3,a3,0x20
 2a4:	0685                	addi	a3,a3,1
 2a6:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 2a8:	0505                	addi	a0,a0,1
    p2++;
 2aa:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ac:	00d50d63          	beq	a0,a3,2c6 <memcmp+0x3e>
    if (*p1 != *p2) {
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	0005c703          	lbu	a4,0(a1)
 2b8:	fee788e3          	beq	a5,a4,2a8 <memcmp+0x20>
      return *p1 - *p2;
 2bc:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret
  return 0;
 2c6:	4501                	li	a0,0
 2c8:	bfe5                	j	2c0 <memcmp+0x38>
 2ca:	4501                	li	a0,0
 2cc:	bfd5                	j	2c0 <memcmp+0x38>

00000000000002ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d6:	00000097          	auipc	ra,0x0
 2da:	f56080e7          	jalr	-170(ra) # 22c <memmove>
}
 2de:	60a2                	ld	ra,8(sp)
 2e0:	6402                	ld	s0,0(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret

00000000000002e6 <close>:

int close(int fd){
 2e6:	1101                	addi	sp,sp,-32
 2e8:	ec06                	sd	ra,24(sp)
 2ea:	e822                	sd	s0,16(sp)
 2ec:	e426                	sd	s1,8(sp)
 2ee:	1000                	addi	s0,sp,32
 2f0:	84aa                	mv	s1,a0
  fflush(fd);
 2f2:	00000097          	auipc	ra,0x0
 2f6:	2da080e7          	jalr	730(ra) # 5cc <fflush>
  char* buf = get_putc_buf(fd);
 2fa:	8526                	mv	a0,s1
 2fc:	00000097          	auipc	ra,0x0
 300:	14e080e7          	jalr	334(ra) # 44a <get_putc_buf>
  if(buf){
 304:	cd11                	beqz	a0,320 <close+0x3a>
    free(buf);
 306:	00000097          	auipc	ra,0x0
 30a:	548080e7          	jalr	1352(ra) # 84e <free>
    putc_buf[fd] = 0;
 30e:	00349713          	slli	a4,s1,0x3
 312:	00000797          	auipc	a5,0x0
 316:	70e78793          	addi	a5,a5,1806 # a20 <putc_buf>
 31a:	97ba                	add	a5,a5,a4
 31c:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 320:	8526                	mv	a0,s1
 322:	00000097          	auipc	ra,0x0
 326:	088080e7          	jalr	136(ra) # 3aa <sclose>
}
 32a:	60e2                	ld	ra,24(sp)
 32c:	6442                	ld	s0,16(sp)
 32e:	64a2                	ld	s1,8(sp)
 330:	6105                	addi	sp,sp,32
 332:	8082                	ret

0000000000000334 <stat>:
{
 334:	1101                	addi	sp,sp,-32
 336:	ec06                	sd	ra,24(sp)
 338:	e822                	sd	s0,16(sp)
 33a:	e426                	sd	s1,8(sp)
 33c:	e04a                	sd	s2,0(sp)
 33e:	1000                	addi	s0,sp,32
 340:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 342:	4581                	li	a1,0
 344:	00000097          	auipc	ra,0x0
 348:	07e080e7          	jalr	126(ra) # 3c2 <open>
  if(fd < 0)
 34c:	02054563          	bltz	a0,376 <stat+0x42>
 350:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 352:	85ca                	mv	a1,s2
 354:	00000097          	auipc	ra,0x0
 358:	086080e7          	jalr	134(ra) # 3da <fstat>
 35c:	892a                	mv	s2,a0
  close(fd);
 35e:	8526                	mv	a0,s1
 360:	00000097          	auipc	ra,0x0
 364:	f86080e7          	jalr	-122(ra) # 2e6 <close>
}
 368:	854a                	mv	a0,s2
 36a:	60e2                	ld	ra,24(sp)
 36c:	6442                	ld	s0,16(sp)
 36e:	64a2                	ld	s1,8(sp)
 370:	6902                	ld	s2,0(sp)
 372:	6105                	addi	sp,sp,32
 374:	8082                	ret
    return -1;
 376:	597d                	li	s2,-1
 378:	bfc5                	j	368 <stat+0x34>

000000000000037a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 37a:	4885                	li	a7,1
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <exit>:
.global exit
exit:
 li a7, SYS_exit
 382:	4889                	li	a7,2
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <wait>:
.global wait
wait:
 li a7, SYS_wait
 38a:	488d                	li	a7,3
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 392:	4891                	li	a7,4
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <read>:
.global read
read:
 li a7, SYS_read
 39a:	4895                	li	a7,5
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <write>:
.global write
write:
 li a7, SYS_write
 3a2:	48c1                	li	a7,16
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 3aa:	48d5                	li	a7,21
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b2:	4899                	li	a7,6
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ba:	489d                	li	a7,7
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <open>:
.global open
open:
 li a7, SYS_open
 3c2:	48bd                	li	a7,15
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ca:	48c5                	li	a7,17
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d2:	48c9                	li	a7,18
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3da:	48a1                	li	a7,8
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <link>:
.global link
link:
 li a7, SYS_link
 3e2:	48cd                	li	a7,19
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ea:	48d1                	li	a7,20
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f2:	48a5                	li	a7,9
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 3fa:	48a9                	li	a7,10
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 402:	48ad                	li	a7,11
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 40a:	48b1                	li	a7,12
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 412:	48b5                	li	a7,13
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 41a:	48b9                	li	a7,14
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 422:	48d9                	li	a7,22
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <nice>:
.global nice
nice:
 li a7, SYS_nice
 42a:	48dd                	li	a7,23
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 432:	48e1                	li	a7,24
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 43a:	48e5                	li	a7,25
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 442:	48e9                	li	a7,26
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 44a:	1101                	addi	sp,sp,-32
 44c:	ec06                	sd	ra,24(sp)
 44e:	e822                	sd	s0,16(sp)
 450:	e426                	sd	s1,8(sp)
 452:	1000                	addi	s0,sp,32
 454:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 456:	00351693          	slli	a3,a0,0x3
 45a:	00000797          	auipc	a5,0x0
 45e:	5c678793          	addi	a5,a5,1478 # a20 <putc_buf>
 462:	97b6                	add	a5,a5,a3
 464:	6388                	ld	a0,0(a5)
  if(buf) {
 466:	c511                	beqz	a0,472 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 468:	60e2                	ld	ra,24(sp)
 46a:	6442                	ld	s0,16(sp)
 46c:	64a2                	ld	s1,8(sp)
 46e:	6105                	addi	sp,sp,32
 470:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 472:	6505                	lui	a0,0x1
 474:	00000097          	auipc	ra,0x0
 478:	464080e7          	jalr	1124(ra) # 8d8 <malloc>
  putc_buf[fd] = buf;
 47c:	00000797          	auipc	a5,0x0
 480:	5a478793          	addi	a5,a5,1444 # a20 <putc_buf>
 484:	00349713          	slli	a4,s1,0x3
 488:	973e                	add	a4,a4,a5
 48a:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 48c:	00249713          	slli	a4,s1,0x2
 490:	973e                	add	a4,a4,a5
 492:	32072023          	sw	zero,800(a4)
  return buf;
 496:	bfc9                	j	468 <get_putc_buf+0x1e>

0000000000000498 <putc>:

static void
putc(int fd, char c)
{
 498:	1101                	addi	sp,sp,-32
 49a:	ec06                	sd	ra,24(sp)
 49c:	e822                	sd	s0,16(sp)
 49e:	e426                	sd	s1,8(sp)
 4a0:	e04a                	sd	s2,0(sp)
 4a2:	1000                	addi	s0,sp,32
 4a4:	84aa                	mv	s1,a0
 4a6:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 4a8:	00000097          	auipc	ra,0x0
 4ac:	fa2080e7          	jalr	-94(ra) # 44a <get_putc_buf>
  buf[putc_index[fd]++] = c;
 4b0:	00249793          	slli	a5,s1,0x2
 4b4:	00000717          	auipc	a4,0x0
 4b8:	56c70713          	addi	a4,a4,1388 # a20 <putc_buf>
 4bc:	973e                	add	a4,a4,a5
 4be:	32072783          	lw	a5,800(a4)
 4c2:	0017869b          	addiw	a3,a5,1
 4c6:	32d72023          	sw	a3,800(a4)
 4ca:	97aa                	add	a5,a5,a0
 4cc:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 4d0:	47a9                	li	a5,10
 4d2:	02f90463          	beq	s2,a5,4fa <putc+0x62>
 4d6:	00249713          	slli	a4,s1,0x2
 4da:	00000797          	auipc	a5,0x0
 4de:	54678793          	addi	a5,a5,1350 # a20 <putc_buf>
 4e2:	97ba                	add	a5,a5,a4
 4e4:	3207a703          	lw	a4,800(a5)
 4e8:	6785                	lui	a5,0x1
 4ea:	00f70863          	beq	a4,a5,4fa <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4ee:	60e2                	ld	ra,24(sp)
 4f0:	6442                	ld	s0,16(sp)
 4f2:	64a2                	ld	s1,8(sp)
 4f4:	6902                	ld	s2,0(sp)
 4f6:	6105                	addi	sp,sp,32
 4f8:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4fa:	00249793          	slli	a5,s1,0x2
 4fe:	00000917          	auipc	s2,0x0
 502:	52290913          	addi	s2,s2,1314 # a20 <putc_buf>
 506:	993e                	add	s2,s2,a5
 508:	32092603          	lw	a2,800(s2)
 50c:	85aa                	mv	a1,a0
 50e:	8526                	mv	a0,s1
 510:	00000097          	auipc	ra,0x0
 514:	e92080e7          	jalr	-366(ra) # 3a2 <write>
    putc_index[fd] = 0;
 518:	32092023          	sw	zero,800(s2)
}
 51c:	bfc9                	j	4ee <putc+0x56>

000000000000051e <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 51e:	7139                	addi	sp,sp,-64
 520:	fc06                	sd	ra,56(sp)
 522:	f822                	sd	s0,48(sp)
 524:	f426                	sd	s1,40(sp)
 526:	f04a                	sd	s2,32(sp)
 528:	ec4e                	sd	s3,24(sp)
 52a:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 52c:	c299                	beqz	a3,532 <printint+0x14>
 52e:	0005cd63          	bltz	a1,548 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 532:	2581                	sext.w	a1,a1
  neg = 0;
 534:	4301                	li	t1,0
 536:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 53a:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 53c:	2601                	sext.w	a2,a2
 53e:	00000897          	auipc	a7,0x0
 542:	4ba88893          	addi	a7,a7,1210 # 9f8 <digits>
 546:	a801                	j	556 <printint+0x38>
    x = -xx;
 548:	40b005bb          	negw	a1,a1
 54c:	2581                	sext.w	a1,a1
    neg = 1;
 54e:	4305                	li	t1,1
    x = -xx;
 550:	b7dd                	j	536 <printint+0x18>
  }while((x /= base) != 0);
 552:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 554:	8836                	mv	a6,a3
 556:	0018069b          	addiw	a3,a6,1
 55a:	02c5f7bb          	remuw	a5,a1,a2
 55e:	1782                	slli	a5,a5,0x20
 560:	9381                	srli	a5,a5,0x20
 562:	97c6                	add	a5,a5,a7
 564:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x120>
 568:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 56c:	0705                	addi	a4,a4,1
 56e:	02c5d7bb          	divuw	a5,a1,a2
 572:	fec5f0e3          	bleu	a2,a1,552 <printint+0x34>
  if(neg)
 576:	00030b63          	beqz	t1,58c <printint+0x6e>
    buf[i++] = '-';
 57a:	fd040793          	addi	a5,s0,-48
 57e:	96be                	add	a3,a3,a5
 580:	02d00793          	li	a5,45
 584:	fef68823          	sb	a5,-16(a3)
 588:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 58c:	02d05963          	blez	a3,5be <printint+0xa0>
 590:	89aa                	mv	s3,a0
 592:	fc040793          	addi	a5,s0,-64
 596:	00d784b3          	add	s1,a5,a3
 59a:	fff78913          	addi	s2,a5,-1
 59e:	9936                	add	s2,s2,a3
 5a0:	36fd                	addiw	a3,a3,-1
 5a2:	1682                	slli	a3,a3,0x20
 5a4:	9281                	srli	a3,a3,0x20
 5a6:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 5aa:	fff4c583          	lbu	a1,-1(s1)
 5ae:	854e                	mv	a0,s3
 5b0:	00000097          	auipc	ra,0x0
 5b4:	ee8080e7          	jalr	-280(ra) # 498 <putc>
  while(--i >= 0)
 5b8:	14fd                	addi	s1,s1,-1
 5ba:	ff2498e3          	bne	s1,s2,5aa <printint+0x8c>
}
 5be:	70e2                	ld	ra,56(sp)
 5c0:	7442                	ld	s0,48(sp)
 5c2:	74a2                	ld	s1,40(sp)
 5c4:	7902                	ld	s2,32(sp)
 5c6:	69e2                	ld	s3,24(sp)
 5c8:	6121                	addi	sp,sp,64
 5ca:	8082                	ret

00000000000005cc <fflush>:
void fflush(int fd){
 5cc:	1101                	addi	sp,sp,-32
 5ce:	ec06                	sd	ra,24(sp)
 5d0:	e822                	sd	s0,16(sp)
 5d2:	e426                	sd	s1,8(sp)
 5d4:	e04a                	sd	s2,0(sp)
 5d6:	1000                	addi	s0,sp,32
 5d8:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 5da:	00000097          	auipc	ra,0x0
 5de:	e70080e7          	jalr	-400(ra) # 44a <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 5e2:	00291793          	slli	a5,s2,0x2
 5e6:	00000497          	auipc	s1,0x0
 5ea:	43a48493          	addi	s1,s1,1082 # a20 <putc_buf>
 5ee:	94be                	add	s1,s1,a5
 5f0:	3204a603          	lw	a2,800(s1)
 5f4:	85aa                	mv	a1,a0
 5f6:	854a                	mv	a0,s2
 5f8:	00000097          	auipc	ra,0x0
 5fc:	daa080e7          	jalr	-598(ra) # 3a2 <write>
  putc_index[fd] = 0;
 600:	3204a023          	sw	zero,800(s1)
}
 604:	60e2                	ld	ra,24(sp)
 606:	6442                	ld	s0,16(sp)
 608:	64a2                	ld	s1,8(sp)
 60a:	6902                	ld	s2,0(sp)
 60c:	6105                	addi	sp,sp,32
 60e:	8082                	ret

0000000000000610 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 610:	7119                	addi	sp,sp,-128
 612:	fc86                	sd	ra,120(sp)
 614:	f8a2                	sd	s0,112(sp)
 616:	f4a6                	sd	s1,104(sp)
 618:	f0ca                	sd	s2,96(sp)
 61a:	ecce                	sd	s3,88(sp)
 61c:	e8d2                	sd	s4,80(sp)
 61e:	e4d6                	sd	s5,72(sp)
 620:	e0da                	sd	s6,64(sp)
 622:	fc5e                	sd	s7,56(sp)
 624:	f862                	sd	s8,48(sp)
 626:	f466                	sd	s9,40(sp)
 628:	f06a                	sd	s10,32(sp)
 62a:	ec6e                	sd	s11,24(sp)
 62c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 62e:	0005c483          	lbu	s1,0(a1)
 632:	18048d63          	beqz	s1,7cc <vprintf+0x1bc>
 636:	8aaa                	mv	s5,a0
 638:	8b32                	mv	s6,a2
 63a:	00158913          	addi	s2,a1,1
  state = 0;
 63e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 640:	02500a13          	li	s4,37
      if(c == 'd'){
 644:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 648:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 64c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 650:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 654:	00000b97          	auipc	s7,0x0
 658:	3a4b8b93          	addi	s7,s7,932 # 9f8 <digits>
 65c:	a839                	j	67a <vprintf+0x6a>
        putc(fd, c);
 65e:	85a6                	mv	a1,s1
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	e36080e7          	jalr	-458(ra) # 498 <putc>
 66a:	a019                	j	670 <vprintf+0x60>
    } else if(state == '%'){
 66c:	01498f63          	beq	s3,s4,68a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 670:	0905                	addi	s2,s2,1
 672:	fff94483          	lbu	s1,-1(s2)
 676:	14048b63          	beqz	s1,7cc <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 67a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 67e:	fe0997e3          	bnez	s3,66c <vprintf+0x5c>
      if(c == '%'){
 682:	fd479ee3          	bne	a5,s4,65e <vprintf+0x4e>
        state = '%';
 686:	89be                	mv	s3,a5
 688:	b7e5                	j	670 <vprintf+0x60>
      if(c == 'd'){
 68a:	05878063          	beq	a5,s8,6ca <vprintf+0xba>
      } else if(c == 'l') {
 68e:	05978c63          	beq	a5,s9,6e6 <vprintf+0xd6>
      } else if(c == 'x') {
 692:	07a78863          	beq	a5,s10,702 <vprintf+0xf2>
      } else if(c == 'p') {
 696:	09b78463          	beq	a5,s11,71e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 69a:	07300713          	li	a4,115
 69e:	0ce78563          	beq	a5,a4,768 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6a2:	06300713          	li	a4,99
 6a6:	0ee78c63          	beq	a5,a4,79e <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6aa:	11478663          	beq	a5,s4,7b6 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ae:	85d2                	mv	a1,s4
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	de6080e7          	jalr	-538(ra) # 498 <putc>
        putc(fd, c);
 6ba:	85a6                	mv	a1,s1
 6bc:	8556                	mv	a0,s5
 6be:	00000097          	auipc	ra,0x0
 6c2:	dda080e7          	jalr	-550(ra) # 498 <putc>
      }
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	b765                	j	670 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6ca:	008b0493          	addi	s1,s6,8
 6ce:	4685                	li	a3,1
 6d0:	4629                	li	a2,10
 6d2:	000b2583          	lw	a1,0(s6)
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	e46080e7          	jalr	-442(ra) # 51e <printint>
 6e0:	8b26                	mv	s6,s1
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	b771                	j	670 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e6:	008b0493          	addi	s1,s6,8
 6ea:	4681                	li	a3,0
 6ec:	4629                	li	a2,10
 6ee:	000b2583          	lw	a1,0(s6)
 6f2:	8556                	mv	a0,s5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	e2a080e7          	jalr	-470(ra) # 51e <printint>
 6fc:	8b26                	mv	s6,s1
      state = 0;
 6fe:	4981                	li	s3,0
 700:	bf85                	j	670 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 702:	008b0493          	addi	s1,s6,8
 706:	4681                	li	a3,0
 708:	4641                	li	a2,16
 70a:	000b2583          	lw	a1,0(s6)
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	e0e080e7          	jalr	-498(ra) # 51e <printint>
 718:	8b26                	mv	s6,s1
      state = 0;
 71a:	4981                	li	s3,0
 71c:	bf91                	j	670 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 71e:	008b0793          	addi	a5,s6,8
 722:	f8f43423          	sd	a5,-120(s0)
 726:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 72a:	03000593          	li	a1,48
 72e:	8556                	mv	a0,s5
 730:	00000097          	auipc	ra,0x0
 734:	d68080e7          	jalr	-664(ra) # 498 <putc>
  putc(fd, 'x');
 738:	85ea                	mv	a1,s10
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	d5c080e7          	jalr	-676(ra) # 498 <putc>
 744:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 746:	03c9d793          	srli	a5,s3,0x3c
 74a:	97de                	add	a5,a5,s7
 74c:	0007c583          	lbu	a1,0(a5)
 750:	8556                	mv	a0,s5
 752:	00000097          	auipc	ra,0x0
 756:	d46080e7          	jalr	-698(ra) # 498 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 75a:	0992                	slli	s3,s3,0x4
 75c:	34fd                	addiw	s1,s1,-1
 75e:	f4e5                	bnez	s1,746 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 760:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 764:	4981                	li	s3,0
 766:	b729                	j	670 <vprintf+0x60>
        s = va_arg(ap, char*);
 768:	008b0993          	addi	s3,s6,8
 76c:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 770:	c085                	beqz	s1,790 <vprintf+0x180>
        while(*s != 0){
 772:	0004c583          	lbu	a1,0(s1)
 776:	c9a1                	beqz	a1,7c6 <vprintf+0x1b6>
          putc(fd, *s);
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	d1e080e7          	jalr	-738(ra) # 498 <putc>
          s++;
 782:	0485                	addi	s1,s1,1
        while(*s != 0){
 784:	0004c583          	lbu	a1,0(s1)
 788:	f9e5                	bnez	a1,778 <vprintf+0x168>
        s = va_arg(ap, char*);
 78a:	8b4e                	mv	s6,s3
      state = 0;
 78c:	4981                	li	s3,0
 78e:	b5cd                	j	670 <vprintf+0x60>
          s = "(null)";
 790:	00000497          	auipc	s1,0x0
 794:	28048493          	addi	s1,s1,640 # a10 <digits+0x18>
        while(*s != 0){
 798:	02800593          	li	a1,40
 79c:	bff1                	j	778 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 79e:	008b0493          	addi	s1,s6,8
 7a2:	000b4583          	lbu	a1,0(s6)
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	cf0080e7          	jalr	-784(ra) # 498 <putc>
 7b0:	8b26                	mv	s6,s1
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	bd75                	j	670 <vprintf+0x60>
        putc(fd, c);
 7b6:	85d2                	mv	a1,s4
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	cde080e7          	jalr	-802(ra) # 498 <putc>
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	b575                	j	670 <vprintf+0x60>
        s = va_arg(ap, char*);
 7c6:	8b4e                	mv	s6,s3
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	b55d                	j	670 <vprintf+0x60>
    }
  }
}
 7cc:	70e6                	ld	ra,120(sp)
 7ce:	7446                	ld	s0,112(sp)
 7d0:	74a6                	ld	s1,104(sp)
 7d2:	7906                	ld	s2,96(sp)
 7d4:	69e6                	ld	s3,88(sp)
 7d6:	6a46                	ld	s4,80(sp)
 7d8:	6aa6                	ld	s5,72(sp)
 7da:	6b06                	ld	s6,64(sp)
 7dc:	7be2                	ld	s7,56(sp)
 7de:	7c42                	ld	s8,48(sp)
 7e0:	7ca2                	ld	s9,40(sp)
 7e2:	7d02                	ld	s10,32(sp)
 7e4:	6de2                	ld	s11,24(sp)
 7e6:	6109                	addi	sp,sp,128
 7e8:	8082                	ret

00000000000007ea <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ea:	715d                	addi	sp,sp,-80
 7ec:	ec06                	sd	ra,24(sp)
 7ee:	e822                	sd	s0,16(sp)
 7f0:	1000                	addi	s0,sp,32
 7f2:	e010                	sd	a2,0(s0)
 7f4:	e414                	sd	a3,8(s0)
 7f6:	e818                	sd	a4,16(s0)
 7f8:	ec1c                	sd	a5,24(s0)
 7fa:	03043023          	sd	a6,32(s0)
 7fe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 802:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 806:	8622                	mv	a2,s0
 808:	00000097          	auipc	ra,0x0
 80c:	e08080e7          	jalr	-504(ra) # 610 <vprintf>
}
 810:	60e2                	ld	ra,24(sp)
 812:	6442                	ld	s0,16(sp)
 814:	6161                	addi	sp,sp,80
 816:	8082                	ret

0000000000000818 <printf>:

void
printf(const char *fmt, ...)
{
 818:	711d                	addi	sp,sp,-96
 81a:	ec06                	sd	ra,24(sp)
 81c:	e822                	sd	s0,16(sp)
 81e:	1000                	addi	s0,sp,32
 820:	e40c                	sd	a1,8(s0)
 822:	e810                	sd	a2,16(s0)
 824:	ec14                	sd	a3,24(s0)
 826:	f018                	sd	a4,32(s0)
 828:	f41c                	sd	a5,40(s0)
 82a:	03043823          	sd	a6,48(s0)
 82e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 832:	00840613          	addi	a2,s0,8
 836:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 83a:	85aa                	mv	a1,a0
 83c:	4505                	li	a0,1
 83e:	00000097          	auipc	ra,0x0
 842:	dd2080e7          	jalr	-558(ra) # 610 <vprintf>
}
 846:	60e2                	ld	ra,24(sp)
 848:	6442                	ld	s0,16(sp)
 84a:	6125                	addi	sp,sp,96
 84c:	8082                	ret

000000000000084e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 84e:	1141                	addi	sp,sp,-16
 850:	e422                	sd	s0,8(sp)
 852:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 854:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x110>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 858:	00000797          	auipc	a5,0x0
 85c:	1c078793          	addi	a5,a5,448 # a18 <__bss_start>
 860:	639c                	ld	a5,0(a5)
 862:	a805                	j	892 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 864:	4618                	lw	a4,8(a2)
 866:	9db9                	addw	a1,a1,a4
 868:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 86c:	6398                	ld	a4,0(a5)
 86e:	6318                	ld	a4,0(a4)
 870:	fee53823          	sd	a4,-16(a0)
 874:	a091                	j	8b8 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 876:	ff852703          	lw	a4,-8(a0)
 87a:	9e39                	addw	a2,a2,a4
 87c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 87e:	ff053703          	ld	a4,-16(a0)
 882:	e398                	sd	a4,0(a5)
 884:	a099                	j	8ca <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 886:	6398                	ld	a4,0(a5)
 888:	00e7e463          	bltu	a5,a4,890 <free+0x42>
 88c:	00e6ea63          	bltu	a3,a4,8a0 <free+0x52>
{
 890:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 892:	fed7fae3          	bleu	a3,a5,886 <free+0x38>
 896:	6398                	ld	a4,0(a5)
 898:	00e6e463          	bltu	a3,a4,8a0 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89c:	fee7eae3          	bltu	a5,a4,890 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 8a0:	ff852583          	lw	a1,-8(a0)
 8a4:	6390                	ld	a2,0(a5)
 8a6:	02059713          	slli	a4,a1,0x20
 8aa:	9301                	srli	a4,a4,0x20
 8ac:	0712                	slli	a4,a4,0x4
 8ae:	9736                	add	a4,a4,a3
 8b0:	fae60ae3          	beq	a2,a4,864 <free+0x16>
    bp->s.ptr = p->s.ptr;
 8b4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8b8:	4790                	lw	a2,8(a5)
 8ba:	02061713          	slli	a4,a2,0x20
 8be:	9301                	srli	a4,a4,0x20
 8c0:	0712                	slli	a4,a4,0x4
 8c2:	973e                	add	a4,a4,a5
 8c4:	fae689e3          	beq	a3,a4,876 <free+0x28>
  } else
    p->s.ptr = bp;
 8c8:	e394                	sd	a3,0(a5)
  freep = p;
 8ca:	00000717          	auipc	a4,0x0
 8ce:	14f73723          	sd	a5,334(a4) # a18 <__bss_start>
}
 8d2:	6422                	ld	s0,8(sp)
 8d4:	0141                	addi	sp,sp,16
 8d6:	8082                	ret

00000000000008d8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8d8:	7139                	addi	sp,sp,-64
 8da:	fc06                	sd	ra,56(sp)
 8dc:	f822                	sd	s0,48(sp)
 8de:	f426                	sd	s1,40(sp)
 8e0:	f04a                	sd	s2,32(sp)
 8e2:	ec4e                	sd	s3,24(sp)
 8e4:	e852                	sd	s4,16(sp)
 8e6:	e456                	sd	s5,8(sp)
 8e8:	e05a                	sd	s6,0(sp)
 8ea:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ec:	02051993          	slli	s3,a0,0x20
 8f0:	0209d993          	srli	s3,s3,0x20
 8f4:	09bd                	addi	s3,s3,15
 8f6:	0049d993          	srli	s3,s3,0x4
 8fa:	2985                	addiw	s3,s3,1
 8fc:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 900:	00000797          	auipc	a5,0x0
 904:	11878793          	addi	a5,a5,280 # a18 <__bss_start>
 908:	6388                	ld	a0,0(a5)
 90a:	c515                	beqz	a0,936 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 90e:	4798                	lw	a4,8(a5)
 910:	03277f63          	bleu	s2,a4,94e <malloc+0x76>
 914:	8a4e                	mv	s4,s3
 916:	0009871b          	sext.w	a4,s3
 91a:	6685                	lui	a3,0x1
 91c:	00d77363          	bleu	a3,a4,922 <malloc+0x4a>
 920:	6a05                	lui	s4,0x1
 922:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 926:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 92a:	00000497          	auipc	s1,0x0
 92e:	0ee48493          	addi	s1,s1,238 # a18 <__bss_start>
  if(p == (char*)-1)
 932:	5b7d                	li	s6,-1
 934:	a885                	j	9a4 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 936:	00000797          	auipc	a5,0x0
 93a:	59a78793          	addi	a5,a5,1434 # ed0 <base>
 93e:	00000717          	auipc	a4,0x0
 942:	0cf73d23          	sd	a5,218(a4) # a18 <__bss_start>
 946:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 948:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 94c:	b7e1                	j	914 <malloc+0x3c>
      if(p->s.size == nunits)
 94e:	02e90b63          	beq	s2,a4,984 <malloc+0xac>
        p->s.size -= nunits;
 952:	4137073b          	subw	a4,a4,s3
 956:	c798                	sw	a4,8(a5)
        p += p->s.size;
 958:	1702                	slli	a4,a4,0x20
 95a:	9301                	srli	a4,a4,0x20
 95c:	0712                	slli	a4,a4,0x4
 95e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 960:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 964:	00000717          	auipc	a4,0x0
 968:	0aa73a23          	sd	a0,180(a4) # a18 <__bss_start>
      return (void*)(p + 1);
 96c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 970:	70e2                	ld	ra,56(sp)
 972:	7442                	ld	s0,48(sp)
 974:	74a2                	ld	s1,40(sp)
 976:	7902                	ld	s2,32(sp)
 978:	69e2                	ld	s3,24(sp)
 97a:	6a42                	ld	s4,16(sp)
 97c:	6aa2                	ld	s5,8(sp)
 97e:	6b02                	ld	s6,0(sp)
 980:	6121                	addi	sp,sp,64
 982:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 984:	6398                	ld	a4,0(a5)
 986:	e118                	sd	a4,0(a0)
 988:	bff1                	j	964 <malloc+0x8c>
  hp->s.size = nu;
 98a:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 98e:	0541                	addi	a0,a0,16
 990:	00000097          	auipc	ra,0x0
 994:	ebe080e7          	jalr	-322(ra) # 84e <free>
  return freep;
 998:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 99a:	d979                	beqz	a0,970 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 99e:	4798                	lw	a4,8(a5)
 9a0:	fb2777e3          	bleu	s2,a4,94e <malloc+0x76>
    if(p == freep)
 9a4:	6098                	ld	a4,0(s1)
 9a6:	853e                	mv	a0,a5
 9a8:	fef71ae3          	bne	a4,a5,99c <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9ac:	8552                	mv	a0,s4
 9ae:	00000097          	auipc	ra,0x0
 9b2:	a5c080e7          	jalr	-1444(ra) # 40a <sbrk>
  if(p == (char*)-1)
 9b6:	fd651ae3          	bne	a0,s6,98a <malloc+0xb2>
        return 0;
 9ba:	4501                	li	a0,0
 9bc:	bf55                	j	970 <malloc+0x98>
