
user/_watchdog-panic:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

int main(){
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	0080                	addi	s0,sp,64
  int watchdog_fd;
  if((watchdog_fd = open("watchdog", O_WRONLY)) < 0){
   e:	4585                	li	a1,1
  10:	00001517          	auipc	a0,0x1
  14:	99050513          	addi	a0,a0,-1648 # 9a0 <malloc+0xe8>
  18:	00000097          	auipc	ra,0x0
  1c:	38a080e7          	jalr	906(ra) # 3a2 <open>
  20:	84aa                	mv	s1,a0
  22:	02054c63          	bltz	a0,5a <main+0x5a>
    mknod("watchdog", 2, 1);
    watchdog_fd = open("watchdog", O_WRONLY);
  }
  while(1){
    printf("Watchdog...\n");
  26:	00001997          	auipc	s3,0x1
  2a:	98a98993          	addi	s3,s3,-1654 # 9b0 <malloc+0xf8>
    char reset = 13;
  2e:	4935                	li	s2,13
    printf("Watchdog...\n");
  30:	854e                	mv	a0,s3
  32:	00000097          	auipc	ra,0x0
  36:	7c6080e7          	jalr	1990(ra) # 7f8 <printf>
    char reset = 13;
  3a:	fd2407a3          	sb	s2,-49(s0)
    write(watchdog_fd, &reset, 1);
  3e:	4605                	li	a2,1
  40:	fcf40593          	addi	a1,s0,-49
  44:	8526                	mv	a0,s1
  46:	00000097          	auipc	ra,0x0
  4a:	33c080e7          	jalr	828(ra) # 382 <write>
    sleep(15);
  4e:	453d                	li	a0,15
  50:	00000097          	auipc	ra,0x0
  54:	3a2080e7          	jalr	930(ra) # 3f2 <sleep>
  while(1){
  58:	bfe1                	j	30 <main+0x30>
    mknod("watchdog", 2, 1);
  5a:	4605                	li	a2,1
  5c:	4589                	li	a1,2
  5e:	00001517          	auipc	a0,0x1
  62:	94250513          	addi	a0,a0,-1726 # 9a0 <malloc+0xe8>
  66:	00000097          	auipc	ra,0x0
  6a:	344080e7          	jalr	836(ra) # 3aa <mknod>
    watchdog_fd = open("watchdog", O_WRONLY);
  6e:	4585                	li	a1,1
  70:	00001517          	auipc	a0,0x1
  74:	93050513          	addi	a0,a0,-1744 # 9a0 <malloc+0xe8>
  78:	00000097          	auipc	ra,0x0
  7c:	32a080e7          	jalr	810(ra) # 3a2 <open>
  80:	84aa                	mv	s1,a0
  82:	b755                	j	26 <main+0x26>

0000000000000084 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  84:	1141                	addi	sp,sp,-16
  86:	e422                	sd	s0,8(sp)
  88:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	87aa                	mv	a5,a0
  8c:	0585                	addi	a1,a1,1
  8e:	0785                	addi	a5,a5,1
  90:	fff5c703          	lbu	a4,-1(a1)
  94:	fee78fa3          	sb	a4,-1(a5)
  98:	fb75                	bnez	a4,8c <strcpy+0x8>
    ;
  return os;
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret

00000000000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	cf91                	beqz	a5,c6 <strcmp+0x26>
  ac:	0005c703          	lbu	a4,0(a1)
  b0:	00f71b63          	bne	a4,a5,c6 <strcmp+0x26>
    p++, q++;
  b4:	0505                	addi	a0,a0,1
  b6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  b8:	00054783          	lbu	a5,0(a0)
  bc:	c789                	beqz	a5,c6 <strcmp+0x26>
  be:	0005c703          	lbu	a4,0(a1)
  c2:	fef709e3          	beq	a4,a5,b4 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  c6:	0005c503          	lbu	a0,0(a1)
}
  ca:	40a7853b          	subw	a0,a5,a0
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <strlen>:

uint
strlen(const char *s)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  da:	00054783          	lbu	a5,0(a0)
  de:	cf91                	beqz	a5,fa <strlen+0x26>
  e0:	0505                	addi	a0,a0,1
  e2:	87aa                	mv	a5,a0
  e4:	4685                	li	a3,1
  e6:	9e89                	subw	a3,a3,a0
  e8:	00f6853b          	addw	a0,a3,a5
  ec:	0785                	addi	a5,a5,1
  ee:	fff7c703          	lbu	a4,-1(a5)
  f2:	fb7d                	bnez	a4,e8 <strlen+0x14>
    ;
  return n;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret
  for(n = 0; s[n]; n++)
  fa:	4501                	li	a0,0
  fc:	bfe5                	j	f4 <strlen+0x20>

00000000000000fe <memset>:

void*
memset(void *dst, int c, uint n)
{
  fe:	1141                	addi	sp,sp,-16
 100:	e422                	sd	s0,8(sp)
 102:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 104:	ce09                	beqz	a2,11e <memset+0x20>
 106:	87aa                	mv	a5,a0
 108:	fff6071b          	addiw	a4,a2,-1
 10c:	1702                	slli	a4,a4,0x20
 10e:	9301                	srli	a4,a4,0x20
 110:	0705                	addi	a4,a4,1
 112:	972a                	add	a4,a4,a0
    cdst[i] = c;
 114:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 118:	0785                	addi	a5,a5,1
 11a:	fee79de3          	bne	a5,a4,114 <memset+0x16>
  }
  return dst;
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	addi	sp,sp,16
 122:	8082                	ret

0000000000000124 <strchr>:

char*
strchr(const char *s, char c)
{
 124:	1141                	addi	sp,sp,-16
 126:	e422                	sd	s0,8(sp)
 128:	0800                	addi	s0,sp,16
  for(; *s; s++)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	cf91                	beqz	a5,14a <strchr+0x26>
    if(*s == c)
 130:	00f58a63          	beq	a1,a5,144 <strchr+0x20>
  for(; *s; s++)
 134:	0505                	addi	a0,a0,1
 136:	00054783          	lbu	a5,0(a0)
 13a:	c781                	beqz	a5,142 <strchr+0x1e>
    if(*s == c)
 13c:	feb79ce3          	bne	a5,a1,134 <strchr+0x10>
 140:	a011                	j	144 <strchr+0x20>
      return (char*)s;
  return 0;
 142:	4501                	li	a0,0
}
 144:	6422                	ld	s0,8(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret
  return 0;
 14a:	4501                	li	a0,0
 14c:	bfe5                	j	144 <strchr+0x20>

000000000000014e <gets>:

char*
gets(char *buf, int max)
{
 14e:	711d                	addi	sp,sp,-96
 150:	ec86                	sd	ra,88(sp)
 152:	e8a2                	sd	s0,80(sp)
 154:	e4a6                	sd	s1,72(sp)
 156:	e0ca                	sd	s2,64(sp)
 158:	fc4e                	sd	s3,56(sp)
 15a:	f852                	sd	s4,48(sp)
 15c:	f456                	sd	s5,40(sp)
 15e:	f05a                	sd	s6,32(sp)
 160:	ec5e                	sd	s7,24(sp)
 162:	1080                	addi	s0,sp,96
 164:	8baa                	mv	s7,a0
 166:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 168:	892a                	mv	s2,a0
 16a:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16c:	4aa9                	li	s5,10
 16e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 170:	0019849b          	addiw	s1,s3,1
 174:	0344d863          	ble	s4,s1,1a4 <gets+0x56>
    cc = read(0, &c, 1);
 178:	4605                	li	a2,1
 17a:	faf40593          	addi	a1,s0,-81
 17e:	4501                	li	a0,0
 180:	00000097          	auipc	ra,0x0
 184:	1fa080e7          	jalr	506(ra) # 37a <read>
    if(cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x56>
    buf[i++] = c;
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 194:	01578763          	beq	a5,s5,1a2 <gets+0x54>
 198:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 19a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 19c:	fd679ae3          	bne	a5,s6,170 <gets+0x22>
 1a0:	a011                	j	1a4 <gets+0x56>
  for(i=0; i+1 < max; ){
 1a2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	addi	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c8:	00054683          	lbu	a3,0(a0)
 1cc:	fd06879b          	addiw	a5,a3,-48
 1d0:	0ff7f793          	andi	a5,a5,255
 1d4:	4725                	li	a4,9
 1d6:	02f76963          	bltu	a4,a5,208 <atoi+0x46>
 1da:	862a                	mv	a2,a0
  n = 0;
 1dc:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1de:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1e0:	0605                	addi	a2,a2,1
 1e2:	0025179b          	slliw	a5,a0,0x2
 1e6:	9fa9                	addw	a5,a5,a0
 1e8:	0017979b          	slliw	a5,a5,0x1
 1ec:	9fb5                	addw	a5,a5,a3
 1ee:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f2:	00064683          	lbu	a3,0(a2)
 1f6:	fd06871b          	addiw	a4,a3,-48
 1fa:	0ff77713          	andi	a4,a4,255
 1fe:	fee5f1e3          	bleu	a4,a1,1e0 <atoi+0x1e>
  return n;
}
 202:	6422                	ld	s0,8(sp)
 204:	0141                	addi	sp,sp,16
 206:	8082                	ret
  n = 0;
 208:	4501                	li	a0,0
 20a:	bfe5                	j	202 <atoi+0x40>

000000000000020c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 212:	02b57663          	bleu	a1,a0,23e <memmove+0x32>
    while(n-- > 0)
 216:	02c05163          	blez	a2,238 <memmove+0x2c>
 21a:	fff6079b          	addiw	a5,a2,-1
 21e:	1782                	slli	a5,a5,0x20
 220:	9381                	srli	a5,a5,0x20
 222:	0785                	addi	a5,a5,1
 224:	97aa                	add	a5,a5,a0
  dst = vdst;
 226:	872a                	mv	a4,a0
      *dst++ = *src++;
 228:	0585                	addi	a1,a1,1
 22a:	0705                	addi	a4,a4,1
 22c:	fff5c683          	lbu	a3,-1(a1)
 230:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 234:	fee79ae3          	bne	a5,a4,228 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret
    dst += n;
 23e:	00c50733          	add	a4,a0,a2
    src += n;
 242:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 244:	fec05ae3          	blez	a2,238 <memmove+0x2c>
 248:	fff6079b          	addiw	a5,a2,-1
 24c:	1782                	slli	a5,a5,0x20
 24e:	9381                	srli	a5,a5,0x20
 250:	fff7c793          	not	a5,a5
 254:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 256:	15fd                	addi	a1,a1,-1
 258:	177d                	addi	a4,a4,-1
 25a:	0005c683          	lbu	a3,0(a1)
 25e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 262:	fef71ae3          	bne	a4,a5,256 <memmove+0x4a>
 266:	bfc9                	j	238 <memmove+0x2c>

0000000000000268 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 26e:	ce15                	beqz	a2,2aa <memcmp+0x42>
 270:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 274:	00054783          	lbu	a5,0(a0)
 278:	0005c703          	lbu	a4,0(a1)
 27c:	02e79063          	bne	a5,a4,29c <memcmp+0x34>
 280:	1682                	slli	a3,a3,0x20
 282:	9281                	srli	a3,a3,0x20
 284:	0685                	addi	a3,a3,1
 286:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 288:	0505                	addi	a0,a0,1
    p2++;
 28a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28c:	00d50d63          	beq	a0,a3,2a6 <memcmp+0x3e>
    if (*p1 != *p2) {
 290:	00054783          	lbu	a5,0(a0)
 294:	0005c703          	lbu	a4,0(a1)
 298:	fee788e3          	beq	a5,a4,288 <memcmp+0x20>
      return *p1 - *p2;
 29c:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
  return 0;
 2a6:	4501                	li	a0,0
 2a8:	bfe5                	j	2a0 <memcmp+0x38>
 2aa:	4501                	li	a0,0
 2ac:	bfd5                	j	2a0 <memcmp+0x38>

00000000000002ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2b6:	00000097          	auipc	ra,0x0
 2ba:	f56080e7          	jalr	-170(ra) # 20c <memmove>
}
 2be:	60a2                	ld	ra,8(sp)
 2c0:	6402                	ld	s0,0(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <close>:

int close(int fd){
 2c6:	1101                	addi	sp,sp,-32
 2c8:	ec06                	sd	ra,24(sp)
 2ca:	e822                	sd	s0,16(sp)
 2cc:	e426                	sd	s1,8(sp)
 2ce:	1000                	addi	s0,sp,32
 2d0:	84aa                	mv	s1,a0
  fflush(fd);
 2d2:	00000097          	auipc	ra,0x0
 2d6:	2da080e7          	jalr	730(ra) # 5ac <fflush>
  char* buf = get_putc_buf(fd);
 2da:	8526                	mv	a0,s1
 2dc:	00000097          	auipc	ra,0x0
 2e0:	14e080e7          	jalr	334(ra) # 42a <get_putc_buf>
  if(buf){
 2e4:	cd11                	beqz	a0,300 <close+0x3a>
    free(buf);
 2e6:	00000097          	auipc	ra,0x0
 2ea:	548080e7          	jalr	1352(ra) # 82e <free>
    putc_buf[fd] = 0;
 2ee:	00349713          	slli	a4,s1,0x3
 2f2:	00000797          	auipc	a5,0x0
 2f6:	6f678793          	addi	a5,a5,1782 # 9e8 <putc_buf>
 2fa:	97ba                	add	a5,a5,a4
 2fc:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 300:	8526                	mv	a0,s1
 302:	00000097          	auipc	ra,0x0
 306:	088080e7          	jalr	136(ra) # 38a <sclose>
}
 30a:	60e2                	ld	ra,24(sp)
 30c:	6442                	ld	s0,16(sp)
 30e:	64a2                	ld	s1,8(sp)
 310:	6105                	addi	sp,sp,32
 312:	8082                	ret

0000000000000314 <stat>:
{
 314:	1101                	addi	sp,sp,-32
 316:	ec06                	sd	ra,24(sp)
 318:	e822                	sd	s0,16(sp)
 31a:	e426                	sd	s1,8(sp)
 31c:	e04a                	sd	s2,0(sp)
 31e:	1000                	addi	s0,sp,32
 320:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 322:	4581                	li	a1,0
 324:	00000097          	auipc	ra,0x0
 328:	07e080e7          	jalr	126(ra) # 3a2 <open>
  if(fd < 0)
 32c:	02054563          	bltz	a0,356 <stat+0x42>
 330:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 332:	85ca                	mv	a1,s2
 334:	00000097          	auipc	ra,0x0
 338:	086080e7          	jalr	134(ra) # 3ba <fstat>
 33c:	892a                	mv	s2,a0
  close(fd);
 33e:	8526                	mv	a0,s1
 340:	00000097          	auipc	ra,0x0
 344:	f86080e7          	jalr	-122(ra) # 2c6 <close>
}
 348:	854a                	mv	a0,s2
 34a:	60e2                	ld	ra,24(sp)
 34c:	6442                	ld	s0,16(sp)
 34e:	64a2                	ld	s1,8(sp)
 350:	6902                	ld	s2,0(sp)
 352:	6105                	addi	sp,sp,32
 354:	8082                	ret
    return -1;
 356:	597d                	li	s2,-1
 358:	bfc5                	j	348 <stat+0x34>

000000000000035a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 35a:	4885                	li	a7,1
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <exit>:
.global exit
exit:
 li a7, SYS_exit
 362:	4889                	li	a7,2
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <wait>:
.global wait
wait:
 li a7, SYS_wait
 36a:	488d                	li	a7,3
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 372:	4891                	li	a7,4
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <read>:
.global read
read:
 li a7, SYS_read
 37a:	4895                	li	a7,5
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <write>:
.global write
write:
 li a7, SYS_write
 382:	48c1                	li	a7,16
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 38a:	48d5                	li	a7,21
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <kill>:
.global kill
kill:
 li a7, SYS_kill
 392:	4899                	li	a7,6
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <exec>:
.global exec
exec:
 li a7, SYS_exec
 39a:	489d                	li	a7,7
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <open>:
.global open
open:
 li a7, SYS_open
 3a2:	48bd                	li	a7,15
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3aa:	48c5                	li	a7,17
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3b2:	48c9                	li	a7,18
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ba:	48a1                	li	a7,8
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <link>:
.global link
link:
 li a7, SYS_link
 3c2:	48cd                	li	a7,19
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ca:	48d1                	li	a7,20
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d2:	48a5                	li	a7,9
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <dup>:
.global dup
dup:
 li a7, SYS_dup
 3da:	48a9                	li	a7,10
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e2:	48ad                	li	a7,11
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ea:	48b1                	li	a7,12
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3f2:	48b5                	li	a7,13
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3fa:	48b9                	li	a7,14
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 402:	48d9                	li	a7,22
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <nice>:
.global nice
nice:
 li a7, SYS_nice
 40a:	48dd                	li	a7,23
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 412:	48e1                	li	a7,24
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 41a:	48e5                	li	a7,25
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 422:	48e9                	li	a7,26
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 42a:	1101                	addi	sp,sp,-32
 42c:	ec06                	sd	ra,24(sp)
 42e:	e822                	sd	s0,16(sp)
 430:	e426                	sd	s1,8(sp)
 432:	1000                	addi	s0,sp,32
 434:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 436:	00351693          	slli	a3,a0,0x3
 43a:	00000797          	auipc	a5,0x0
 43e:	5ae78793          	addi	a5,a5,1454 # 9e8 <putc_buf>
 442:	97b6                	add	a5,a5,a3
 444:	6388                	ld	a0,0(a5)
  if(buf) {
 446:	c511                	beqz	a0,452 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 448:	60e2                	ld	ra,24(sp)
 44a:	6442                	ld	s0,16(sp)
 44c:	64a2                	ld	s1,8(sp)
 44e:	6105                	addi	sp,sp,32
 450:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 452:	6505                	lui	a0,0x1
 454:	00000097          	auipc	ra,0x0
 458:	464080e7          	jalr	1124(ra) # 8b8 <malloc>
  putc_buf[fd] = buf;
 45c:	00000797          	auipc	a5,0x0
 460:	58c78793          	addi	a5,a5,1420 # 9e8 <putc_buf>
 464:	00349713          	slli	a4,s1,0x3
 468:	973e                	add	a4,a4,a5
 46a:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 46c:	00249713          	slli	a4,s1,0x2
 470:	973e                	add	a4,a4,a5
 472:	32072023          	sw	zero,800(a4)
  return buf;
 476:	bfc9                	j	448 <get_putc_buf+0x1e>

0000000000000478 <putc>:

static void
putc(int fd, char c)
{
 478:	1101                	addi	sp,sp,-32
 47a:	ec06                	sd	ra,24(sp)
 47c:	e822                	sd	s0,16(sp)
 47e:	e426                	sd	s1,8(sp)
 480:	e04a                	sd	s2,0(sp)
 482:	1000                	addi	s0,sp,32
 484:	84aa                	mv	s1,a0
 486:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 488:	00000097          	auipc	ra,0x0
 48c:	fa2080e7          	jalr	-94(ra) # 42a <get_putc_buf>
  buf[putc_index[fd]++] = c;
 490:	00249793          	slli	a5,s1,0x2
 494:	00000717          	auipc	a4,0x0
 498:	55470713          	addi	a4,a4,1364 # 9e8 <putc_buf>
 49c:	973e                	add	a4,a4,a5
 49e:	32072783          	lw	a5,800(a4)
 4a2:	0017869b          	addiw	a3,a5,1
 4a6:	32d72023          	sw	a3,800(a4)
 4aa:	97aa                	add	a5,a5,a0
 4ac:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 4b0:	47a9                	li	a5,10
 4b2:	02f90463          	beq	s2,a5,4da <putc+0x62>
 4b6:	00249713          	slli	a4,s1,0x2
 4ba:	00000797          	auipc	a5,0x0
 4be:	52e78793          	addi	a5,a5,1326 # 9e8 <putc_buf>
 4c2:	97ba                	add	a5,a5,a4
 4c4:	3207a703          	lw	a4,800(a5)
 4c8:	6785                	lui	a5,0x1
 4ca:	00f70863          	beq	a4,a5,4da <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4ce:	60e2                	ld	ra,24(sp)
 4d0:	6442                	ld	s0,16(sp)
 4d2:	64a2                	ld	s1,8(sp)
 4d4:	6902                	ld	s2,0(sp)
 4d6:	6105                	addi	sp,sp,32
 4d8:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4da:	00249793          	slli	a5,s1,0x2
 4de:	00000917          	auipc	s2,0x0
 4e2:	50a90913          	addi	s2,s2,1290 # 9e8 <putc_buf>
 4e6:	993e                	add	s2,s2,a5
 4e8:	32092603          	lw	a2,800(s2)
 4ec:	85aa                	mv	a1,a0
 4ee:	8526                	mv	a0,s1
 4f0:	00000097          	auipc	ra,0x0
 4f4:	e92080e7          	jalr	-366(ra) # 382 <write>
    putc_index[fd] = 0;
 4f8:	32092023          	sw	zero,800(s2)
}
 4fc:	bfc9                	j	4ce <putc+0x56>

00000000000004fe <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4fe:	7139                	addi	sp,sp,-64
 500:	fc06                	sd	ra,56(sp)
 502:	f822                	sd	s0,48(sp)
 504:	f426                	sd	s1,40(sp)
 506:	f04a                	sd	s2,32(sp)
 508:	ec4e                	sd	s3,24(sp)
 50a:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 50c:	c299                	beqz	a3,512 <printint+0x14>
 50e:	0005cd63          	bltz	a1,528 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 512:	2581                	sext.w	a1,a1
  neg = 0;
 514:	4301                	li	t1,0
 516:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 51a:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 51c:	2601                	sext.w	a2,a2
 51e:	00000897          	auipc	a7,0x0
 522:	4a288893          	addi	a7,a7,1186 # 9c0 <digits>
 526:	a801                	j	536 <printint+0x38>
    x = -xx;
 528:	40b005bb          	negw	a1,a1
 52c:	2581                	sext.w	a1,a1
    neg = 1;
 52e:	4305                	li	t1,1
    x = -xx;
 530:	b7dd                	j	516 <printint+0x18>
  }while((x /= base) != 0);
 532:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 534:	8836                	mv	a6,a3
 536:	0018069b          	addiw	a3,a6,1
 53a:	02c5f7bb          	remuw	a5,a1,a2
 53e:	1782                	slli	a5,a5,0x20
 540:	9381                	srli	a5,a5,0x20
 542:	97c6                	add	a5,a5,a7
 544:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x158>
 548:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 54c:	0705                	addi	a4,a4,1
 54e:	02c5d7bb          	divuw	a5,a1,a2
 552:	fec5f0e3          	bleu	a2,a1,532 <printint+0x34>
  if(neg)
 556:	00030b63          	beqz	t1,56c <printint+0x6e>
    buf[i++] = '-';
 55a:	fd040793          	addi	a5,s0,-48
 55e:	96be                	add	a3,a3,a5
 560:	02d00793          	li	a5,45
 564:	fef68823          	sb	a5,-16(a3)
 568:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 56c:	02d05963          	blez	a3,59e <printint+0xa0>
 570:	89aa                	mv	s3,a0
 572:	fc040793          	addi	a5,s0,-64
 576:	00d784b3          	add	s1,a5,a3
 57a:	fff78913          	addi	s2,a5,-1
 57e:	9936                	add	s2,s2,a3
 580:	36fd                	addiw	a3,a3,-1
 582:	1682                	slli	a3,a3,0x20
 584:	9281                	srli	a3,a3,0x20
 586:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 58a:	fff4c583          	lbu	a1,-1(s1)
 58e:	854e                	mv	a0,s3
 590:	00000097          	auipc	ra,0x0
 594:	ee8080e7          	jalr	-280(ra) # 478 <putc>
  while(--i >= 0)
 598:	14fd                	addi	s1,s1,-1
 59a:	ff2498e3          	bne	s1,s2,58a <printint+0x8c>
}
 59e:	70e2                	ld	ra,56(sp)
 5a0:	7442                	ld	s0,48(sp)
 5a2:	74a2                	ld	s1,40(sp)
 5a4:	7902                	ld	s2,32(sp)
 5a6:	69e2                	ld	s3,24(sp)
 5a8:	6121                	addi	sp,sp,64
 5aa:	8082                	ret

00000000000005ac <fflush>:
void fflush(int fd){
 5ac:	1101                	addi	sp,sp,-32
 5ae:	ec06                	sd	ra,24(sp)
 5b0:	e822                	sd	s0,16(sp)
 5b2:	e426                	sd	s1,8(sp)
 5b4:	e04a                	sd	s2,0(sp)
 5b6:	1000                	addi	s0,sp,32
 5b8:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 5ba:	00000097          	auipc	ra,0x0
 5be:	e70080e7          	jalr	-400(ra) # 42a <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 5c2:	00291793          	slli	a5,s2,0x2
 5c6:	00000497          	auipc	s1,0x0
 5ca:	42248493          	addi	s1,s1,1058 # 9e8 <putc_buf>
 5ce:	94be                	add	s1,s1,a5
 5d0:	3204a603          	lw	a2,800(s1)
 5d4:	85aa                	mv	a1,a0
 5d6:	854a                	mv	a0,s2
 5d8:	00000097          	auipc	ra,0x0
 5dc:	daa080e7          	jalr	-598(ra) # 382 <write>
  putc_index[fd] = 0;
 5e0:	3204a023          	sw	zero,800(s1)
}
 5e4:	60e2                	ld	ra,24(sp)
 5e6:	6442                	ld	s0,16(sp)
 5e8:	64a2                	ld	s1,8(sp)
 5ea:	6902                	ld	s2,0(sp)
 5ec:	6105                	addi	sp,sp,32
 5ee:	8082                	ret

00000000000005f0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5f0:	7119                	addi	sp,sp,-128
 5f2:	fc86                	sd	ra,120(sp)
 5f4:	f8a2                	sd	s0,112(sp)
 5f6:	f4a6                	sd	s1,104(sp)
 5f8:	f0ca                	sd	s2,96(sp)
 5fa:	ecce                	sd	s3,88(sp)
 5fc:	e8d2                	sd	s4,80(sp)
 5fe:	e4d6                	sd	s5,72(sp)
 600:	e0da                	sd	s6,64(sp)
 602:	fc5e                	sd	s7,56(sp)
 604:	f862                	sd	s8,48(sp)
 606:	f466                	sd	s9,40(sp)
 608:	f06a                	sd	s10,32(sp)
 60a:	ec6e                	sd	s11,24(sp)
 60c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 60e:	0005c483          	lbu	s1,0(a1)
 612:	18048d63          	beqz	s1,7ac <vprintf+0x1bc>
 616:	8aaa                	mv	s5,a0
 618:	8b32                	mv	s6,a2
 61a:	00158913          	addi	s2,a1,1
  state = 0;
 61e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 620:	02500a13          	li	s4,37
      if(c == 'd'){
 624:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 628:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 62c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 630:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 634:	00000b97          	auipc	s7,0x0
 638:	38cb8b93          	addi	s7,s7,908 # 9c0 <digits>
 63c:	a839                	j	65a <vprintf+0x6a>
        putc(fd, c);
 63e:	85a6                	mv	a1,s1
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	e36080e7          	jalr	-458(ra) # 478 <putc>
 64a:	a019                	j	650 <vprintf+0x60>
    } else if(state == '%'){
 64c:	01498f63          	beq	s3,s4,66a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 650:	0905                	addi	s2,s2,1
 652:	fff94483          	lbu	s1,-1(s2)
 656:	14048b63          	beqz	s1,7ac <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 65a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 65e:	fe0997e3          	bnez	s3,64c <vprintf+0x5c>
      if(c == '%'){
 662:	fd479ee3          	bne	a5,s4,63e <vprintf+0x4e>
        state = '%';
 666:	89be                	mv	s3,a5
 668:	b7e5                	j	650 <vprintf+0x60>
      if(c == 'd'){
 66a:	05878063          	beq	a5,s8,6aa <vprintf+0xba>
      } else if(c == 'l') {
 66e:	05978c63          	beq	a5,s9,6c6 <vprintf+0xd6>
      } else if(c == 'x') {
 672:	07a78863          	beq	a5,s10,6e2 <vprintf+0xf2>
      } else if(c == 'p') {
 676:	09b78463          	beq	a5,s11,6fe <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 67a:	07300713          	li	a4,115
 67e:	0ce78563          	beq	a5,a4,748 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 682:	06300713          	li	a4,99
 686:	0ee78c63          	beq	a5,a4,77e <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 68a:	11478663          	beq	a5,s4,796 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 68e:	85d2                	mv	a1,s4
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	de6080e7          	jalr	-538(ra) # 478 <putc>
        putc(fd, c);
 69a:	85a6                	mv	a1,s1
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	dda080e7          	jalr	-550(ra) # 478 <putc>
      }
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	b765                	j	650 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6aa:	008b0493          	addi	s1,s6,8
 6ae:	4685                	li	a3,1
 6b0:	4629                	li	a2,10
 6b2:	000b2583          	lw	a1,0(s6)
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	e46080e7          	jalr	-442(ra) # 4fe <printint>
 6c0:	8b26                	mv	s6,s1
      state = 0;
 6c2:	4981                	li	s3,0
 6c4:	b771                	j	650 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c6:	008b0493          	addi	s1,s6,8
 6ca:	4681                	li	a3,0
 6cc:	4629                	li	a2,10
 6ce:	000b2583          	lw	a1,0(s6)
 6d2:	8556                	mv	a0,s5
 6d4:	00000097          	auipc	ra,0x0
 6d8:	e2a080e7          	jalr	-470(ra) # 4fe <printint>
 6dc:	8b26                	mv	s6,s1
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	bf85                	j	650 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6e2:	008b0493          	addi	s1,s6,8
 6e6:	4681                	li	a3,0
 6e8:	4641                	li	a2,16
 6ea:	000b2583          	lw	a1,0(s6)
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	e0e080e7          	jalr	-498(ra) # 4fe <printint>
 6f8:	8b26                	mv	s6,s1
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	bf91                	j	650 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6fe:	008b0793          	addi	a5,s6,8
 702:	f8f43423          	sd	a5,-120(s0)
 706:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 70a:	03000593          	li	a1,48
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	d68080e7          	jalr	-664(ra) # 478 <putc>
  putc(fd, 'x');
 718:	85ea                	mv	a1,s10
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	d5c080e7          	jalr	-676(ra) # 478 <putc>
 724:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 726:	03c9d793          	srli	a5,s3,0x3c
 72a:	97de                	add	a5,a5,s7
 72c:	0007c583          	lbu	a1,0(a5)
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	d46080e7          	jalr	-698(ra) # 478 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 73a:	0992                	slli	s3,s3,0x4
 73c:	34fd                	addiw	s1,s1,-1
 73e:	f4e5                	bnez	s1,726 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 740:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 744:	4981                	li	s3,0
 746:	b729                	j	650 <vprintf+0x60>
        s = va_arg(ap, char*);
 748:	008b0993          	addi	s3,s6,8
 74c:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 750:	c085                	beqz	s1,770 <vprintf+0x180>
        while(*s != 0){
 752:	0004c583          	lbu	a1,0(s1)
 756:	c9a1                	beqz	a1,7a6 <vprintf+0x1b6>
          putc(fd, *s);
 758:	8556                	mv	a0,s5
 75a:	00000097          	auipc	ra,0x0
 75e:	d1e080e7          	jalr	-738(ra) # 478 <putc>
          s++;
 762:	0485                	addi	s1,s1,1
        while(*s != 0){
 764:	0004c583          	lbu	a1,0(s1)
 768:	f9e5                	bnez	a1,758 <vprintf+0x168>
        s = va_arg(ap, char*);
 76a:	8b4e                	mv	s6,s3
      state = 0;
 76c:	4981                	li	s3,0
 76e:	b5cd                	j	650 <vprintf+0x60>
          s = "(null)";
 770:	00000497          	auipc	s1,0x0
 774:	26848493          	addi	s1,s1,616 # 9d8 <digits+0x18>
        while(*s != 0){
 778:	02800593          	li	a1,40
 77c:	bff1                	j	758 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 77e:	008b0493          	addi	s1,s6,8
 782:	000b4583          	lbu	a1,0(s6)
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	cf0080e7          	jalr	-784(ra) # 478 <putc>
 790:	8b26                	mv	s6,s1
      state = 0;
 792:	4981                	li	s3,0
 794:	bd75                	j	650 <vprintf+0x60>
        putc(fd, c);
 796:	85d2                	mv	a1,s4
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	cde080e7          	jalr	-802(ra) # 478 <putc>
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	b575                	j	650 <vprintf+0x60>
        s = va_arg(ap, char*);
 7a6:	8b4e                	mv	s6,s3
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b55d                	j	650 <vprintf+0x60>
    }
  }
}
 7ac:	70e6                	ld	ra,120(sp)
 7ae:	7446                	ld	s0,112(sp)
 7b0:	74a6                	ld	s1,104(sp)
 7b2:	7906                	ld	s2,96(sp)
 7b4:	69e6                	ld	s3,88(sp)
 7b6:	6a46                	ld	s4,80(sp)
 7b8:	6aa6                	ld	s5,72(sp)
 7ba:	6b06                	ld	s6,64(sp)
 7bc:	7be2                	ld	s7,56(sp)
 7be:	7c42                	ld	s8,48(sp)
 7c0:	7ca2                	ld	s9,40(sp)
 7c2:	7d02                	ld	s10,32(sp)
 7c4:	6de2                	ld	s11,24(sp)
 7c6:	6109                	addi	sp,sp,128
 7c8:	8082                	ret

00000000000007ca <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ca:	715d                	addi	sp,sp,-80
 7cc:	ec06                	sd	ra,24(sp)
 7ce:	e822                	sd	s0,16(sp)
 7d0:	1000                	addi	s0,sp,32
 7d2:	e010                	sd	a2,0(s0)
 7d4:	e414                	sd	a3,8(s0)
 7d6:	e818                	sd	a4,16(s0)
 7d8:	ec1c                	sd	a5,24(s0)
 7da:	03043023          	sd	a6,32(s0)
 7de:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e6:	8622                	mv	a2,s0
 7e8:	00000097          	auipc	ra,0x0
 7ec:	e08080e7          	jalr	-504(ra) # 5f0 <vprintf>
}
 7f0:	60e2                	ld	ra,24(sp)
 7f2:	6442                	ld	s0,16(sp)
 7f4:	6161                	addi	sp,sp,80
 7f6:	8082                	ret

00000000000007f8 <printf>:

void
printf(const char *fmt, ...)
{
 7f8:	711d                	addi	sp,sp,-96
 7fa:	ec06                	sd	ra,24(sp)
 7fc:	e822                	sd	s0,16(sp)
 7fe:	1000                	addi	s0,sp,32
 800:	e40c                	sd	a1,8(s0)
 802:	e810                	sd	a2,16(s0)
 804:	ec14                	sd	a3,24(s0)
 806:	f018                	sd	a4,32(s0)
 808:	f41c                	sd	a5,40(s0)
 80a:	03043823          	sd	a6,48(s0)
 80e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 812:	00840613          	addi	a2,s0,8
 816:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 81a:	85aa                	mv	a1,a0
 81c:	4505                	li	a0,1
 81e:	00000097          	auipc	ra,0x0
 822:	dd2080e7          	jalr	-558(ra) # 5f0 <vprintf>
}
 826:	60e2                	ld	ra,24(sp)
 828:	6442                	ld	s0,16(sp)
 82a:	6125                	addi	sp,sp,96
 82c:	8082                	ret

000000000000082e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 82e:	1141                	addi	sp,sp,-16
 830:	e422                	sd	s0,8(sp)
 832:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 834:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x148>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 838:	00000797          	auipc	a5,0x0
 83c:	1a878793          	addi	a5,a5,424 # 9e0 <__bss_start>
 840:	639c                	ld	a5,0(a5)
 842:	a805                	j	872 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 844:	4618                	lw	a4,8(a2)
 846:	9db9                	addw	a1,a1,a4
 848:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 84c:	6398                	ld	a4,0(a5)
 84e:	6318                	ld	a4,0(a4)
 850:	fee53823          	sd	a4,-16(a0)
 854:	a091                	j	898 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 856:	ff852703          	lw	a4,-8(a0)
 85a:	9e39                	addw	a2,a2,a4
 85c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 85e:	ff053703          	ld	a4,-16(a0)
 862:	e398                	sd	a4,0(a5)
 864:	a099                	j	8aa <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 866:	6398                	ld	a4,0(a5)
 868:	00e7e463          	bltu	a5,a4,870 <free+0x42>
 86c:	00e6ea63          	bltu	a3,a4,880 <free+0x52>
{
 870:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 872:	fed7fae3          	bleu	a3,a5,866 <free+0x38>
 876:	6398                	ld	a4,0(a5)
 878:	00e6e463          	bltu	a3,a4,880 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87c:	fee7eae3          	bltu	a5,a4,870 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 880:	ff852583          	lw	a1,-8(a0)
 884:	6390                	ld	a2,0(a5)
 886:	02059713          	slli	a4,a1,0x20
 88a:	9301                	srli	a4,a4,0x20
 88c:	0712                	slli	a4,a4,0x4
 88e:	9736                	add	a4,a4,a3
 890:	fae60ae3          	beq	a2,a4,844 <free+0x16>
    bp->s.ptr = p->s.ptr;
 894:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 898:	4790                	lw	a2,8(a5)
 89a:	02061713          	slli	a4,a2,0x20
 89e:	9301                	srli	a4,a4,0x20
 8a0:	0712                	slli	a4,a4,0x4
 8a2:	973e                	add	a4,a4,a5
 8a4:	fae689e3          	beq	a3,a4,856 <free+0x28>
  } else
    p->s.ptr = bp;
 8a8:	e394                	sd	a3,0(a5)
  freep = p;
 8aa:	00000717          	auipc	a4,0x0
 8ae:	12f73b23          	sd	a5,310(a4) # 9e0 <__bss_start>
}
 8b2:	6422                	ld	s0,8(sp)
 8b4:	0141                	addi	sp,sp,16
 8b6:	8082                	ret

00000000000008b8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b8:	7139                	addi	sp,sp,-64
 8ba:	fc06                	sd	ra,56(sp)
 8bc:	f822                	sd	s0,48(sp)
 8be:	f426                	sd	s1,40(sp)
 8c0:	f04a                	sd	s2,32(sp)
 8c2:	ec4e                	sd	s3,24(sp)
 8c4:	e852                	sd	s4,16(sp)
 8c6:	e456                	sd	s5,8(sp)
 8c8:	e05a                	sd	s6,0(sp)
 8ca:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8cc:	02051993          	slli	s3,a0,0x20
 8d0:	0209d993          	srli	s3,s3,0x20
 8d4:	09bd                	addi	s3,s3,15
 8d6:	0049d993          	srli	s3,s3,0x4
 8da:	2985                	addiw	s3,s3,1
 8dc:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8e0:	00000797          	auipc	a5,0x0
 8e4:	10078793          	addi	a5,a5,256 # 9e0 <__bss_start>
 8e8:	6388                	ld	a0,0(a5)
 8ea:	c515                	beqz	a0,916 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ee:	4798                	lw	a4,8(a5)
 8f0:	03277f63          	bleu	s2,a4,92e <malloc+0x76>
 8f4:	8a4e                	mv	s4,s3
 8f6:	0009871b          	sext.w	a4,s3
 8fa:	6685                	lui	a3,0x1
 8fc:	00d77363          	bleu	a3,a4,902 <malloc+0x4a>
 900:	6a05                	lui	s4,0x1
 902:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 906:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 90a:	00000497          	auipc	s1,0x0
 90e:	0d648493          	addi	s1,s1,214 # 9e0 <__bss_start>
  if(p == (char*)-1)
 912:	5b7d                	li	s6,-1
 914:	a885                	j	984 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 916:	00000797          	auipc	a5,0x0
 91a:	58278793          	addi	a5,a5,1410 # e98 <base>
 91e:	00000717          	auipc	a4,0x0
 922:	0cf73123          	sd	a5,194(a4) # 9e0 <__bss_start>
 926:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 928:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 92c:	b7e1                	j	8f4 <malloc+0x3c>
      if(p->s.size == nunits)
 92e:	02e90b63          	beq	s2,a4,964 <malloc+0xac>
        p->s.size -= nunits;
 932:	4137073b          	subw	a4,a4,s3
 936:	c798                	sw	a4,8(a5)
        p += p->s.size;
 938:	1702                	slli	a4,a4,0x20
 93a:	9301                	srli	a4,a4,0x20
 93c:	0712                	slli	a4,a4,0x4
 93e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 940:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 944:	00000717          	auipc	a4,0x0
 948:	08a73e23          	sd	a0,156(a4) # 9e0 <__bss_start>
      return (void*)(p + 1);
 94c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 950:	70e2                	ld	ra,56(sp)
 952:	7442                	ld	s0,48(sp)
 954:	74a2                	ld	s1,40(sp)
 956:	7902                	ld	s2,32(sp)
 958:	69e2                	ld	s3,24(sp)
 95a:	6a42                	ld	s4,16(sp)
 95c:	6aa2                	ld	s5,8(sp)
 95e:	6b02                	ld	s6,0(sp)
 960:	6121                	addi	sp,sp,64
 962:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 964:	6398                	ld	a4,0(a5)
 966:	e118                	sd	a4,0(a0)
 968:	bff1                	j	944 <malloc+0x8c>
  hp->s.size = nu;
 96a:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 96e:	0541                	addi	a0,a0,16
 970:	00000097          	auipc	ra,0x0
 974:	ebe080e7          	jalr	-322(ra) # 82e <free>
  return freep;
 978:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 97a:	d979                	beqz	a0,950 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 97e:	4798                	lw	a4,8(a5)
 980:	fb2777e3          	bleu	s2,a4,92e <malloc+0x76>
    if(p == freep)
 984:	6098                	ld	a4,0(s1)
 986:	853e                	mv	a0,a5
 988:	fef71ae3          	bne	a4,a5,97c <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 98c:	8552                	mv	a0,s4
 98e:	00000097          	auipc	ra,0x0
 992:	a5c080e7          	jalr	-1444(ra) # 3ea <sbrk>
  if(p == (char*)-1)
 996:	fd651ae3          	bne	a0,s6,96a <malloc+0xb2>
        return 0;
 99a:	4501                	li	a0,0
 99c:	bf55                	j	950 <malloc+0x98>
