
user/_mutest2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <freadint>:

char fname[] = "moncompteur";

#define MAXLEN 20

int freadint(){
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	0080                	addi	s0,sp,64
  int res = -1;
  char buf[MAXLEN];
  int fd = open(fname, O_RDONLY);
   c:	4581                	li	a1,0
   e:	00001517          	auipc	a0,0x1
  12:	b6250513          	addi	a0,a0,-1182 # b70 <fname>
  16:	00000097          	auipc	ra,0x0
  1a:	510080e7          	jalr	1296(ra) # 526 <open>
  1e:	892a                	mv	s2,a0
  if(read(fd, buf, MAXLEN) > 0){
  20:	4651                	li	a2,20
  22:	fc840593          	addi	a1,s0,-56
  26:	00000097          	auipc	ra,0x0
  2a:	4d8080e7          	jalr	1240(ra) # 4fe <read>
  2e:	02a05563          	blez	a0,58 <freadint+0x58>
    res = atoi(buf);
  32:	fc840513          	addi	a0,s0,-56
  36:	00000097          	auipc	ra,0x0
  3a:	310080e7          	jalr	784(ra) # 346 <atoi>
  3e:	84aa                	mv	s1,a0
  }
  close(fd);
  40:	854a                	mv	a0,s2
  42:	00000097          	auipc	ra,0x0
  46:	408080e7          	jalr	1032(ra) # 44a <close>
  return res;
}
  4a:	8526                	mv	a0,s1
  4c:	70e2                	ld	ra,56(sp)
  4e:	7442                	ld	s0,48(sp)
  50:	74a2                	ld	s1,40(sp)
  52:	7902                	ld	s2,32(sp)
  54:	6121                	addi	sp,sp,64
  56:	8082                	ret
  int res = -1;
  58:	54fd                	li	s1,-1
  5a:	b7dd                	j	40 <freadint+0x40>

000000000000005c <fwriteint>:

void fwriteint(int i){
  5c:	1101                	addi	sp,sp,-32
  5e:	ec06                	sd	ra,24(sp)
  60:	e822                	sd	s0,16(sp)
  62:	e426                	sd	s1,8(sp)
  64:	e04a                	sd	s2,0(sp)
  66:	1000                	addi	s0,sp,32
  68:	892a                	mv	s2,a0
  int fd = open(fname, O_CREATE | O_RDWR);
  6a:	20200593          	li	a1,514
  6e:	00001517          	auipc	a0,0x1
  72:	b0250513          	addi	a0,a0,-1278 # b70 <fname>
  76:	00000097          	auipc	ra,0x0
  7a:	4b0080e7          	jalr	1200(ra) # 526 <open>
  7e:	84aa                	mv	s1,a0
  fprintf(fd, "%d\n", i);
  80:	864a                	mv	a2,s2
  82:	00001597          	auipc	a1,0x1
  86:	aa658593          	addi	a1,a1,-1370 # b28 <malloc+0xec>
  8a:	00001097          	auipc	ra,0x1
  8e:	8c4080e7          	jalr	-1852(ra) # 94e <fprintf>
  close(fd);
  92:	8526                	mv	a0,s1
  94:	00000097          	auipc	ra,0x0
  98:	3b6080e7          	jalr	950(ra) # 44a <close>
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	6442                	ld	s0,16(sp)
  a0:	64a2                	ld	s1,8(sp)
  a2:	6902                	ld	s2,0(sp)
  a4:	6105                	addi	sp,sp,32
  a6:	8082                	ret

00000000000000a8 <inc>:

#define NITER 100

void inc(int mut){
  a8:	1101                	addi	sp,sp,-32
  aa:	ec06                	sd	ra,24(sp)
  ac:	e822                	sd	s0,16(sp)
  ae:	e426                	sd	s1,8(sp)
  b0:	e04a                	sd	s2,0(sp)
  b2:	1000                	addi	s0,sp,32
  b4:	892a                	mv	s2,a0
  b6:	06400493          	li	s1,100
  for(int i = 0; i < NITER; i++){
    acquire_mutex(mut);
  ba:	854a                	mv	a0,s2
  bc:	00000097          	auipc	ra,0x0
  c0:	4e2080e7          	jalr	1250(ra) # 59e <acquire_mutex>
    int val = freadint();
  c4:	00000097          	auipc	ra,0x0
  c8:	f3c080e7          	jalr	-196(ra) # 0 <freadint>
    fwriteint(val+1);
  cc:	2505                	addiw	a0,a0,1
  ce:	00000097          	auipc	ra,0x0
  d2:	f8e080e7          	jalr	-114(ra) # 5c <fwriteint>
    release_mutex(mut);
  d6:	854a                	mv	a0,s2
  d8:	00000097          	auipc	ra,0x0
  dc:	4ce080e7          	jalr	1230(ra) # 5a6 <release_mutex>
  for(int i = 0; i < NITER; i++){
  e0:	34fd                	addiw	s1,s1,-1
  e2:	fce1                	bnez	s1,ba <inc+0x12>
  }
}
  e4:	60e2                	ld	ra,24(sp)
  e6:	6442                	ld	s0,16(sp)
  e8:	64a2                	ld	s1,8(sp)
  ea:	6902                	ld	s2,0(sp)
  ec:	6105                	addi	sp,sp,32
  ee:	8082                	ret

00000000000000f0 <dec>:

void dec(int mut){
  f0:	1101                	addi	sp,sp,-32
  f2:	ec06                	sd	ra,24(sp)
  f4:	e822                	sd	s0,16(sp)
  f6:	e426                	sd	s1,8(sp)
  f8:	e04a                	sd	s2,0(sp)
  fa:	1000                	addi	s0,sp,32
  fc:	892a                	mv	s2,a0
  fe:	06400493          	li	s1,100
  for(int i = 0; i < NITER; i++){
    acquire_mutex(mut);
 102:	854a                	mv	a0,s2
 104:	00000097          	auipc	ra,0x0
 108:	49a080e7          	jalr	1178(ra) # 59e <acquire_mutex>
    int val = freadint();
 10c:	00000097          	auipc	ra,0x0
 110:	ef4080e7          	jalr	-268(ra) # 0 <freadint>
    fwriteint(val-1);
 114:	357d                	addiw	a0,a0,-1
 116:	00000097          	auipc	ra,0x0
 11a:	f46080e7          	jalr	-186(ra) # 5c <fwriteint>
    release_mutex(mut);
 11e:	854a                	mv	a0,s2
 120:	00000097          	auipc	ra,0x0
 124:	486080e7          	jalr	1158(ra) # 5a6 <release_mutex>
  for(int i = 0; i < NITER; i++){
 128:	34fd                	addiw	s1,s1,-1
 12a:	fce1                	bnez	s1,102 <dec+0x12>
  }
}
 12c:	60e2                	ld	ra,24(sp)
 12e:	6442                	ld	s0,16(sp)
 130:	64a2                	ld	s1,8(sp)
 132:	6902                	ld	s2,0(sp)
 134:	6105                	addi	sp,sp,32
 136:	8082                	ret

0000000000000138 <main>:


int main(){
 138:	1101                	addi	sp,sp,-32
 13a:	ec06                	sd	ra,24(sp)
 13c:	e822                	sd	s0,16(sp)
 13e:	e426                	sd	s1,8(sp)
 140:	1000                	addi	s0,sp,32
  fwriteint(100);
 142:	06400513          	li	a0,100
 146:	00000097          	auipc	ra,0x0
 14a:	f16080e7          	jalr	-234(ra) # 5c <fwriteint>
  int mut = create_mutex();
 14e:	00000097          	auipc	ra,0x0
 152:	448080e7          	jalr	1096(ra) # 596 <create_mutex>
 156:	84aa                	mv	s1,a0
  int pid = fork();
 158:	00000097          	auipc	ra,0x0
 15c:	386080e7          	jalr	902(ra) # 4de <fork>
  if(pid < 0){
 160:	00054d63          	bltz	a0,17a <main+0x42>
    printf("error fork\n");
    exit(1);
  } else if (pid == 0){
 164:	e905                	bnez	a0,194 <main+0x5c>
    inc(mut);
 166:	8526                	mv	a0,s1
 168:	00000097          	auipc	ra,0x0
 16c:	f40080e7          	jalr	-192(ra) # a8 <inc>
    exit(0);
 170:	4501                	li	a0,0
 172:	00000097          	auipc	ra,0x0
 176:	374080e7          	jalr	884(ra) # 4e6 <exit>
    printf("error fork\n");
 17a:	00001517          	auipc	a0,0x1
 17e:	9b650513          	addi	a0,a0,-1610 # b30 <malloc+0xf4>
 182:	00000097          	auipc	ra,0x0
 186:	7fa080e7          	jalr	2042(ra) # 97c <printf>
    exit(1);
 18a:	4505                	li	a0,1
 18c:	00000097          	auipc	ra,0x0
 190:	35a080e7          	jalr	858(ra) # 4e6 <exit>
  } else {
    pid = fork();
 194:	00000097          	auipc	ra,0x0
 198:	34a080e7          	jalr	842(ra) # 4de <fork>
    if(pid < 0){
 19c:	00054d63          	bltz	a0,1b6 <main+0x7e>
      printf("error fork\n");
      exit(1);
    } else if (pid == 0){
 1a0:	e905                	bnez	a0,1d0 <main+0x98>
      dec(mut);
 1a2:	8526                	mv	a0,s1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	f4c080e7          	jalr	-180(ra) # f0 <dec>
      exit(0);
 1ac:	4501                	li	a0,0
 1ae:	00000097          	auipc	ra,0x0
 1b2:	338080e7          	jalr	824(ra) # 4e6 <exit>
      printf("error fork\n");
 1b6:	00001517          	auipc	a0,0x1
 1ba:	97a50513          	addi	a0,a0,-1670 # b30 <malloc+0xf4>
 1be:	00000097          	auipc	ra,0x0
 1c2:	7be080e7          	jalr	1982(ra) # 97c <printf>
      exit(1);
 1c6:	4505                	li	a0,1
 1c8:	00000097          	auipc	ra,0x0
 1cc:	31e080e7          	jalr	798(ra) # 4e6 <exit>
    }
    wait(0);
 1d0:	4501                	li	a0,0
 1d2:	00000097          	auipc	ra,0x0
 1d6:	31c080e7          	jalr	796(ra) # 4ee <wait>
    wait(0);
 1da:	4501                	li	a0,0
 1dc:	00000097          	auipc	ra,0x0
 1e0:	312080e7          	jalr	786(ra) # 4ee <wait>
    printf("Result = %d\n", freadint());
 1e4:	00000097          	auipc	ra,0x0
 1e8:	e1c080e7          	jalr	-484(ra) # 0 <freadint>
 1ec:	85aa                	mv	a1,a0
 1ee:	00001517          	auipc	a0,0x1
 1f2:	95250513          	addi	a0,a0,-1710 # b40 <malloc+0x104>
 1f6:	00000097          	auipc	ra,0x0
 1fa:	786080e7          	jalr	1926(ra) # 97c <printf>
    exit(0);
 1fe:	4501                	li	a0,0
 200:	00000097          	auipc	ra,0x0
 204:	2e6080e7          	jalr	742(ra) # 4e6 <exit>

0000000000000208 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 208:	1141                	addi	sp,sp,-16
 20a:	e422                	sd	s0,8(sp)
 20c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 20e:	87aa                	mv	a5,a0
 210:	0585                	addi	a1,a1,1
 212:	0785                	addi	a5,a5,1
 214:	fff5c703          	lbu	a4,-1(a1)
 218:	fee78fa3          	sb	a4,-1(a5)
 21c:	fb75                	bnez	a4,210 <strcpy+0x8>
    ;
  return os;
}
 21e:	6422                	ld	s0,8(sp)
 220:	0141                	addi	sp,sp,16
 222:	8082                	ret

0000000000000224 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 224:	1141                	addi	sp,sp,-16
 226:	e422                	sd	s0,8(sp)
 228:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 22a:	00054783          	lbu	a5,0(a0)
 22e:	cf91                	beqz	a5,24a <strcmp+0x26>
 230:	0005c703          	lbu	a4,0(a1)
 234:	00f71b63          	bne	a4,a5,24a <strcmp+0x26>
    p++, q++;
 238:	0505                	addi	a0,a0,1
 23a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 23c:	00054783          	lbu	a5,0(a0)
 240:	c789                	beqz	a5,24a <strcmp+0x26>
 242:	0005c703          	lbu	a4,0(a1)
 246:	fef709e3          	beq	a4,a5,238 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 24a:	0005c503          	lbu	a0,0(a1)
}
 24e:	40a7853b          	subw	a0,a5,a0
 252:	6422                	ld	s0,8(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret

0000000000000258 <strlen>:

uint
strlen(const char *s)
{
 258:	1141                	addi	sp,sp,-16
 25a:	e422                	sd	s0,8(sp)
 25c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 25e:	00054783          	lbu	a5,0(a0)
 262:	cf91                	beqz	a5,27e <strlen+0x26>
 264:	0505                	addi	a0,a0,1
 266:	87aa                	mv	a5,a0
 268:	4685                	li	a3,1
 26a:	9e89                	subw	a3,a3,a0
 26c:	00f6853b          	addw	a0,a3,a5
 270:	0785                	addi	a5,a5,1
 272:	fff7c703          	lbu	a4,-1(a5)
 276:	fb7d                	bnez	a4,26c <strlen+0x14>
    ;
  return n;
}
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret
  for(n = 0; s[n]; n++)
 27e:	4501                	li	a0,0
 280:	bfe5                	j	278 <strlen+0x20>

0000000000000282 <memset>:

void*
memset(void *dst, int c, uint n)
{
 282:	1141                	addi	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 288:	ce09                	beqz	a2,2a2 <memset+0x20>
 28a:	87aa                	mv	a5,a0
 28c:	fff6071b          	addiw	a4,a2,-1
 290:	1702                	slli	a4,a4,0x20
 292:	9301                	srli	a4,a4,0x20
 294:	0705                	addi	a4,a4,1
 296:	972a                	add	a4,a4,a0
    cdst[i] = c;
 298:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 29c:	0785                	addi	a5,a5,1
 29e:	fee79de3          	bne	a5,a4,298 <memset+0x16>
  }
  return dst;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <strchr>:

char*
strchr(const char *s, char c)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	cf91                	beqz	a5,2ce <strchr+0x26>
    if(*s == c)
 2b4:	00f58a63          	beq	a1,a5,2c8 <strchr+0x20>
  for(; *s; s++)
 2b8:	0505                	addi	a0,a0,1
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	c781                	beqz	a5,2c6 <strchr+0x1e>
    if(*s == c)
 2c0:	feb79ce3          	bne	a5,a1,2b8 <strchr+0x10>
 2c4:	a011                	j	2c8 <strchr+0x20>
      return (char*)s;
  return 0;
 2c6:	4501                	li	a0,0
}
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret
  return 0;
 2ce:	4501                	li	a0,0
 2d0:	bfe5                	j	2c8 <strchr+0x20>

00000000000002d2 <gets>:

char*
gets(char *buf, int max)
{
 2d2:	711d                	addi	sp,sp,-96
 2d4:	ec86                	sd	ra,88(sp)
 2d6:	e8a2                	sd	s0,80(sp)
 2d8:	e4a6                	sd	s1,72(sp)
 2da:	e0ca                	sd	s2,64(sp)
 2dc:	fc4e                	sd	s3,56(sp)
 2de:	f852                	sd	s4,48(sp)
 2e0:	f456                	sd	s5,40(sp)
 2e2:	f05a                	sd	s6,32(sp)
 2e4:	ec5e                	sd	s7,24(sp)
 2e6:	1080                	addi	s0,sp,96
 2e8:	8baa                	mv	s7,a0
 2ea:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ec:	892a                	mv	s2,a0
 2ee:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2f0:	4aa9                	li	s5,10
 2f2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2f4:	0019849b          	addiw	s1,s3,1
 2f8:	0344d863          	ble	s4,s1,328 <gets+0x56>
    cc = read(0, &c, 1);
 2fc:	4605                	li	a2,1
 2fe:	faf40593          	addi	a1,s0,-81
 302:	4501                	li	a0,0
 304:	00000097          	auipc	ra,0x0
 308:	1fa080e7          	jalr	506(ra) # 4fe <read>
    if(cc < 1)
 30c:	00a05e63          	blez	a0,328 <gets+0x56>
    buf[i++] = c;
 310:	faf44783          	lbu	a5,-81(s0)
 314:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 318:	01578763          	beq	a5,s5,326 <gets+0x54>
 31c:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 31e:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 320:	fd679ae3          	bne	a5,s6,2f4 <gets+0x22>
 324:	a011                	j	328 <gets+0x56>
  for(i=0; i+1 < max; ){
 326:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 328:	99de                	add	s3,s3,s7
 32a:	00098023          	sb	zero,0(s3)
  return buf;
}
 32e:	855e                	mv	a0,s7
 330:	60e6                	ld	ra,88(sp)
 332:	6446                	ld	s0,80(sp)
 334:	64a6                	ld	s1,72(sp)
 336:	6906                	ld	s2,64(sp)
 338:	79e2                	ld	s3,56(sp)
 33a:	7a42                	ld	s4,48(sp)
 33c:	7aa2                	ld	s5,40(sp)
 33e:	7b02                	ld	s6,32(sp)
 340:	6be2                	ld	s7,24(sp)
 342:	6125                	addi	sp,sp,96
 344:	8082                	ret

0000000000000346 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34c:	00054683          	lbu	a3,0(a0)
 350:	fd06879b          	addiw	a5,a3,-48
 354:	0ff7f793          	andi	a5,a5,255
 358:	4725                	li	a4,9
 35a:	02f76963          	bltu	a4,a5,38c <atoi+0x46>
 35e:	862a                	mv	a2,a0
  n = 0;
 360:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 362:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 364:	0605                	addi	a2,a2,1
 366:	0025179b          	slliw	a5,a0,0x2
 36a:	9fa9                	addw	a5,a5,a0
 36c:	0017979b          	slliw	a5,a5,0x1
 370:	9fb5                	addw	a5,a5,a3
 372:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 376:	00064683          	lbu	a3,0(a2)
 37a:	fd06871b          	addiw	a4,a3,-48
 37e:	0ff77713          	andi	a4,a4,255
 382:	fee5f1e3          	bleu	a4,a1,364 <atoi+0x1e>
  return n;
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret
  n = 0;
 38c:	4501                	li	a0,0
 38e:	bfe5                	j	386 <atoi+0x40>

0000000000000390 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 390:	1141                	addi	sp,sp,-16
 392:	e422                	sd	s0,8(sp)
 394:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 396:	02b57663          	bleu	a1,a0,3c2 <memmove+0x32>
    while(n-- > 0)
 39a:	02c05163          	blez	a2,3bc <memmove+0x2c>
 39e:	fff6079b          	addiw	a5,a2,-1
 3a2:	1782                	slli	a5,a5,0x20
 3a4:	9381                	srli	a5,a5,0x20
 3a6:	0785                	addi	a5,a5,1
 3a8:	97aa                	add	a5,a5,a0
  dst = vdst;
 3aa:	872a                	mv	a4,a0
      *dst++ = *src++;
 3ac:	0585                	addi	a1,a1,1
 3ae:	0705                	addi	a4,a4,1
 3b0:	fff5c683          	lbu	a3,-1(a1)
 3b4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3b8:	fee79ae3          	bne	a5,a4,3ac <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3bc:	6422                	ld	s0,8(sp)
 3be:	0141                	addi	sp,sp,16
 3c0:	8082                	ret
    dst += n;
 3c2:	00c50733          	add	a4,a0,a2
    src += n;
 3c6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3c8:	fec05ae3          	blez	a2,3bc <memmove+0x2c>
 3cc:	fff6079b          	addiw	a5,a2,-1
 3d0:	1782                	slli	a5,a5,0x20
 3d2:	9381                	srli	a5,a5,0x20
 3d4:	fff7c793          	not	a5,a5
 3d8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3da:	15fd                	addi	a1,a1,-1
 3dc:	177d                	addi	a4,a4,-1
 3de:	0005c683          	lbu	a3,0(a1)
 3e2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3e6:	fef71ae3          	bne	a4,a5,3da <memmove+0x4a>
 3ea:	bfc9                	j	3bc <memmove+0x2c>

00000000000003ec <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ec:	1141                	addi	sp,sp,-16
 3ee:	e422                	sd	s0,8(sp)
 3f0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3f2:	ce15                	beqz	a2,42e <memcmp+0x42>
 3f4:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 3f8:	00054783          	lbu	a5,0(a0)
 3fc:	0005c703          	lbu	a4,0(a1)
 400:	02e79063          	bne	a5,a4,420 <memcmp+0x34>
 404:	1682                	slli	a3,a3,0x20
 406:	9281                	srli	a3,a3,0x20
 408:	0685                	addi	a3,a3,1
 40a:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 40c:	0505                	addi	a0,a0,1
    p2++;
 40e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 410:	00d50d63          	beq	a0,a3,42a <memcmp+0x3e>
    if (*p1 != *p2) {
 414:	00054783          	lbu	a5,0(a0)
 418:	0005c703          	lbu	a4,0(a1)
 41c:	fee788e3          	beq	a5,a4,40c <memcmp+0x20>
      return *p1 - *p2;
 420:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 424:	6422                	ld	s0,8(sp)
 426:	0141                	addi	sp,sp,16
 428:	8082                	ret
  return 0;
 42a:	4501                	li	a0,0
 42c:	bfe5                	j	424 <memcmp+0x38>
 42e:	4501                	li	a0,0
 430:	bfd5                	j	424 <memcmp+0x38>

0000000000000432 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 432:	1141                	addi	sp,sp,-16
 434:	e406                	sd	ra,8(sp)
 436:	e022                	sd	s0,0(sp)
 438:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 43a:	00000097          	auipc	ra,0x0
 43e:	f56080e7          	jalr	-170(ra) # 390 <memmove>
}
 442:	60a2                	ld	ra,8(sp)
 444:	6402                	ld	s0,0(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret

000000000000044a <close>:

int close(int fd){
 44a:	1101                	addi	sp,sp,-32
 44c:	ec06                	sd	ra,24(sp)
 44e:	e822                	sd	s0,16(sp)
 450:	e426                	sd	s1,8(sp)
 452:	1000                	addi	s0,sp,32
 454:	84aa                	mv	s1,a0
  fflush(fd);
 456:	00000097          	auipc	ra,0x0
 45a:	2da080e7          	jalr	730(ra) # 730 <fflush>
  char* buf = get_putc_buf(fd);
 45e:	8526                	mv	a0,s1
 460:	00000097          	auipc	ra,0x0
 464:	14e080e7          	jalr	334(ra) # 5ae <get_putc_buf>
  if(buf){
 468:	cd11                	beqz	a0,484 <close+0x3a>
    free(buf);
 46a:	00000097          	auipc	ra,0x0
 46e:	548080e7          	jalr	1352(ra) # 9b2 <free>
    putc_buf[fd] = 0;
 472:	00349713          	slli	a4,s1,0x3
 476:	00000797          	auipc	a5,0x0
 47a:	71278793          	addi	a5,a5,1810 # b88 <putc_buf>
 47e:	97ba                	add	a5,a5,a4
 480:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 484:	8526                	mv	a0,s1
 486:	00000097          	auipc	ra,0x0
 48a:	088080e7          	jalr	136(ra) # 50e <sclose>
}
 48e:	60e2                	ld	ra,24(sp)
 490:	6442                	ld	s0,16(sp)
 492:	64a2                	ld	s1,8(sp)
 494:	6105                	addi	sp,sp,32
 496:	8082                	ret

0000000000000498 <stat>:
{
 498:	1101                	addi	sp,sp,-32
 49a:	ec06                	sd	ra,24(sp)
 49c:	e822                	sd	s0,16(sp)
 49e:	e426                	sd	s1,8(sp)
 4a0:	e04a                	sd	s2,0(sp)
 4a2:	1000                	addi	s0,sp,32
 4a4:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 4a6:	4581                	li	a1,0
 4a8:	00000097          	auipc	ra,0x0
 4ac:	07e080e7          	jalr	126(ra) # 526 <open>
  if(fd < 0)
 4b0:	02054563          	bltz	a0,4da <stat+0x42>
 4b4:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 4b6:	85ca                	mv	a1,s2
 4b8:	00000097          	auipc	ra,0x0
 4bc:	086080e7          	jalr	134(ra) # 53e <fstat>
 4c0:	892a                	mv	s2,a0
  close(fd);
 4c2:	8526                	mv	a0,s1
 4c4:	00000097          	auipc	ra,0x0
 4c8:	f86080e7          	jalr	-122(ra) # 44a <close>
}
 4cc:	854a                	mv	a0,s2
 4ce:	60e2                	ld	ra,24(sp)
 4d0:	6442                	ld	s0,16(sp)
 4d2:	64a2                	ld	s1,8(sp)
 4d4:	6902                	ld	s2,0(sp)
 4d6:	6105                	addi	sp,sp,32
 4d8:	8082                	ret
    return -1;
 4da:	597d                	li	s2,-1
 4dc:	bfc5                	j	4cc <stat+0x34>

00000000000004de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4de:	4885                	li	a7,1
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e6:	4889                	li	a7,2
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ee:	488d                	li	a7,3
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f6:	4891                	li	a7,4
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <read>:
.global read
read:
 li a7, SYS_read
 4fe:	4895                	li	a7,5
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <write>:
.global write
write:
 li a7, SYS_write
 506:	48c1                	li	a7,16
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 50e:	48d5                	li	a7,21
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <kill>:
.global kill
kill:
 li a7, SYS_kill
 516:	4899                	li	a7,6
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <exec>:
.global exec
exec:
 li a7, SYS_exec
 51e:	489d                	li	a7,7
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <open>:
.global open
open:
 li a7, SYS_open
 526:	48bd                	li	a7,15
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 52e:	48c5                	li	a7,17
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 536:	48c9                	li	a7,18
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 53e:	48a1                	li	a7,8
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <link>:
.global link
link:
 li a7, SYS_link
 546:	48cd                	li	a7,19
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 54e:	48d1                	li	a7,20
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 556:	48a5                	li	a7,9
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <dup>:
.global dup
dup:
 li a7, SYS_dup
 55e:	48a9                	li	a7,10
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 566:	48ad                	li	a7,11
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 56e:	48b1                	li	a7,12
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 576:	48b5                	li	a7,13
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 57e:	48b9                	li	a7,14
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 586:	48d9                	li	a7,22
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <nice>:
.global nice
nice:
 li a7, SYS_nice
 58e:	48dd                	li	a7,23
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 596:	48e1                	li	a7,24
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 59e:	48e5                	li	a7,25
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 5a6:	48e9                	li	a7,26
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 5ae:	1101                	addi	sp,sp,-32
 5b0:	ec06                	sd	ra,24(sp)
 5b2:	e822                	sd	s0,16(sp)
 5b4:	e426                	sd	s1,8(sp)
 5b6:	1000                	addi	s0,sp,32
 5b8:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 5ba:	00351693          	slli	a3,a0,0x3
 5be:	00000797          	auipc	a5,0x0
 5c2:	5ca78793          	addi	a5,a5,1482 # b88 <putc_buf>
 5c6:	97b6                	add	a5,a5,a3
 5c8:	6388                	ld	a0,0(a5)
  if(buf) {
 5ca:	c511                	beqz	a0,5d6 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 5cc:	60e2                	ld	ra,24(sp)
 5ce:	6442                	ld	s0,16(sp)
 5d0:	64a2                	ld	s1,8(sp)
 5d2:	6105                	addi	sp,sp,32
 5d4:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 5d6:	6505                	lui	a0,0x1
 5d8:	00000097          	auipc	ra,0x0
 5dc:	464080e7          	jalr	1124(ra) # a3c <malloc>
  putc_buf[fd] = buf;
 5e0:	00000797          	auipc	a5,0x0
 5e4:	5a878793          	addi	a5,a5,1448 # b88 <putc_buf>
 5e8:	00349713          	slli	a4,s1,0x3
 5ec:	973e                	add	a4,a4,a5
 5ee:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 5f0:	00249713          	slli	a4,s1,0x2
 5f4:	973e                	add	a4,a4,a5
 5f6:	32072023          	sw	zero,800(a4)
  return buf;
 5fa:	bfc9                	j	5cc <get_putc_buf+0x1e>

00000000000005fc <putc>:

static void
putc(int fd, char c)
{
 5fc:	1101                	addi	sp,sp,-32
 5fe:	ec06                	sd	ra,24(sp)
 600:	e822                	sd	s0,16(sp)
 602:	e426                	sd	s1,8(sp)
 604:	e04a                	sd	s2,0(sp)
 606:	1000                	addi	s0,sp,32
 608:	84aa                	mv	s1,a0
 60a:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 60c:	00000097          	auipc	ra,0x0
 610:	fa2080e7          	jalr	-94(ra) # 5ae <get_putc_buf>
  buf[putc_index[fd]++] = c;
 614:	00249793          	slli	a5,s1,0x2
 618:	00000717          	auipc	a4,0x0
 61c:	57070713          	addi	a4,a4,1392 # b88 <putc_buf>
 620:	973e                	add	a4,a4,a5
 622:	32072783          	lw	a5,800(a4)
 626:	0017869b          	addiw	a3,a5,1
 62a:	32d72023          	sw	a3,800(a4)
 62e:	97aa                	add	a5,a5,a0
 630:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 634:	47a9                	li	a5,10
 636:	02f90463          	beq	s2,a5,65e <putc+0x62>
 63a:	00249713          	slli	a4,s1,0x2
 63e:	00000797          	auipc	a5,0x0
 642:	54a78793          	addi	a5,a5,1354 # b88 <putc_buf>
 646:	97ba                	add	a5,a5,a4
 648:	3207a703          	lw	a4,800(a5)
 64c:	6785                	lui	a5,0x1
 64e:	00f70863          	beq	a4,a5,65e <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 652:	60e2                	ld	ra,24(sp)
 654:	6442                	ld	s0,16(sp)
 656:	64a2                	ld	s1,8(sp)
 658:	6902                	ld	s2,0(sp)
 65a:	6105                	addi	sp,sp,32
 65c:	8082                	ret
    write(fd, buf, putc_index[fd]);
 65e:	00249793          	slli	a5,s1,0x2
 662:	00000917          	auipc	s2,0x0
 666:	52690913          	addi	s2,s2,1318 # b88 <putc_buf>
 66a:	993e                	add	s2,s2,a5
 66c:	32092603          	lw	a2,800(s2)
 670:	85aa                	mv	a1,a0
 672:	8526                	mv	a0,s1
 674:	00000097          	auipc	ra,0x0
 678:	e92080e7          	jalr	-366(ra) # 506 <write>
    putc_index[fd] = 0;
 67c:	32092023          	sw	zero,800(s2)
}
 680:	bfc9                	j	652 <putc+0x56>

0000000000000682 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 682:	7139                	addi	sp,sp,-64
 684:	fc06                	sd	ra,56(sp)
 686:	f822                	sd	s0,48(sp)
 688:	f426                	sd	s1,40(sp)
 68a:	f04a                	sd	s2,32(sp)
 68c:	ec4e                	sd	s3,24(sp)
 68e:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 690:	c299                	beqz	a3,696 <printint+0x14>
 692:	0005cd63          	bltz	a1,6ac <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 696:	2581                	sext.w	a1,a1
  neg = 0;
 698:	4301                	li	t1,0
 69a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 69e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 6a0:	2601                	sext.w	a2,a2
 6a2:	00000897          	auipc	a7,0x0
 6a6:	4ae88893          	addi	a7,a7,1198 # b50 <digits>
 6aa:	a801                	j	6ba <printint+0x38>
    x = -xx;
 6ac:	40b005bb          	negw	a1,a1
 6b0:	2581                	sext.w	a1,a1
    neg = 1;
 6b2:	4305                	li	t1,1
    x = -xx;
 6b4:	b7dd                	j	69a <printint+0x18>
  }while((x /= base) != 0);
 6b6:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 6b8:	8836                	mv	a6,a3
 6ba:	0018069b          	addiw	a3,a6,1
 6be:	02c5f7bb          	remuw	a5,a1,a2
 6c2:	1782                	slli	a5,a5,0x20
 6c4:	9381                	srli	a5,a5,0x20
 6c6:	97c6                	add	a5,a5,a7
 6c8:	0007c783          	lbu	a5,0(a5) # 1000 <putc_index+0x158>
 6cc:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 6d0:	0705                	addi	a4,a4,1
 6d2:	02c5d7bb          	divuw	a5,a1,a2
 6d6:	fec5f0e3          	bleu	a2,a1,6b6 <printint+0x34>
  if(neg)
 6da:	00030b63          	beqz	t1,6f0 <printint+0x6e>
    buf[i++] = '-';
 6de:	fd040793          	addi	a5,s0,-48
 6e2:	96be                	add	a3,a3,a5
 6e4:	02d00793          	li	a5,45
 6e8:	fef68823          	sb	a5,-16(a3)
 6ec:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 6f0:	02d05963          	blez	a3,722 <printint+0xa0>
 6f4:	89aa                	mv	s3,a0
 6f6:	fc040793          	addi	a5,s0,-64
 6fa:	00d784b3          	add	s1,a5,a3
 6fe:	fff78913          	addi	s2,a5,-1
 702:	9936                	add	s2,s2,a3
 704:	36fd                	addiw	a3,a3,-1
 706:	1682                	slli	a3,a3,0x20
 708:	9281                	srli	a3,a3,0x20
 70a:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 70e:	fff4c583          	lbu	a1,-1(s1)
 712:	854e                	mv	a0,s3
 714:	00000097          	auipc	ra,0x0
 718:	ee8080e7          	jalr	-280(ra) # 5fc <putc>
  while(--i >= 0)
 71c:	14fd                	addi	s1,s1,-1
 71e:	ff2498e3          	bne	s1,s2,70e <printint+0x8c>
}
 722:	70e2                	ld	ra,56(sp)
 724:	7442                	ld	s0,48(sp)
 726:	74a2                	ld	s1,40(sp)
 728:	7902                	ld	s2,32(sp)
 72a:	69e2                	ld	s3,24(sp)
 72c:	6121                	addi	sp,sp,64
 72e:	8082                	ret

0000000000000730 <fflush>:
void fflush(int fd){
 730:	1101                	addi	sp,sp,-32
 732:	ec06                	sd	ra,24(sp)
 734:	e822                	sd	s0,16(sp)
 736:	e426                	sd	s1,8(sp)
 738:	e04a                	sd	s2,0(sp)
 73a:	1000                	addi	s0,sp,32
 73c:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 73e:	00000097          	auipc	ra,0x0
 742:	e70080e7          	jalr	-400(ra) # 5ae <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 746:	00291793          	slli	a5,s2,0x2
 74a:	00000497          	auipc	s1,0x0
 74e:	43e48493          	addi	s1,s1,1086 # b88 <putc_buf>
 752:	94be                	add	s1,s1,a5
 754:	3204a603          	lw	a2,800(s1)
 758:	85aa                	mv	a1,a0
 75a:	854a                	mv	a0,s2
 75c:	00000097          	auipc	ra,0x0
 760:	daa080e7          	jalr	-598(ra) # 506 <write>
  putc_index[fd] = 0;
 764:	3204a023          	sw	zero,800(s1)
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	64a2                	ld	s1,8(sp)
 76e:	6902                	ld	s2,0(sp)
 770:	6105                	addi	sp,sp,32
 772:	8082                	ret

0000000000000774 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 774:	7119                	addi	sp,sp,-128
 776:	fc86                	sd	ra,120(sp)
 778:	f8a2                	sd	s0,112(sp)
 77a:	f4a6                	sd	s1,104(sp)
 77c:	f0ca                	sd	s2,96(sp)
 77e:	ecce                	sd	s3,88(sp)
 780:	e8d2                	sd	s4,80(sp)
 782:	e4d6                	sd	s5,72(sp)
 784:	e0da                	sd	s6,64(sp)
 786:	fc5e                	sd	s7,56(sp)
 788:	f862                	sd	s8,48(sp)
 78a:	f466                	sd	s9,40(sp)
 78c:	f06a                	sd	s10,32(sp)
 78e:	ec6e                	sd	s11,24(sp)
 790:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 792:	0005c483          	lbu	s1,0(a1)
 796:	18048d63          	beqz	s1,930 <vprintf+0x1bc>
 79a:	8aaa                	mv	s5,a0
 79c:	8b32                	mv	s6,a2
 79e:	00158913          	addi	s2,a1,1
  state = 0;
 7a2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7a4:	02500a13          	li	s4,37
      if(c == 'd'){
 7a8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 7ac:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 7b0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 7b4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b8:	00000b97          	auipc	s7,0x0
 7bc:	398b8b93          	addi	s7,s7,920 # b50 <digits>
 7c0:	a839                	j	7de <vprintf+0x6a>
        putc(fd, c);
 7c2:	85a6                	mv	a1,s1
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	e36080e7          	jalr	-458(ra) # 5fc <putc>
 7ce:	a019                	j	7d4 <vprintf+0x60>
    } else if(state == '%'){
 7d0:	01498f63          	beq	s3,s4,7ee <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7d4:	0905                	addi	s2,s2,1
 7d6:	fff94483          	lbu	s1,-1(s2)
 7da:	14048b63          	beqz	s1,930 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 7de:	0004879b          	sext.w	a5,s1
    if(state == 0){
 7e2:	fe0997e3          	bnez	s3,7d0 <vprintf+0x5c>
      if(c == '%'){
 7e6:	fd479ee3          	bne	a5,s4,7c2 <vprintf+0x4e>
        state = '%';
 7ea:	89be                	mv	s3,a5
 7ec:	b7e5                	j	7d4 <vprintf+0x60>
      if(c == 'd'){
 7ee:	05878063          	beq	a5,s8,82e <vprintf+0xba>
      } else if(c == 'l') {
 7f2:	05978c63          	beq	a5,s9,84a <vprintf+0xd6>
      } else if(c == 'x') {
 7f6:	07a78863          	beq	a5,s10,866 <vprintf+0xf2>
      } else if(c == 'p') {
 7fa:	09b78463          	beq	a5,s11,882 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7fe:	07300713          	li	a4,115
 802:	0ce78563          	beq	a5,a4,8cc <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 806:	06300713          	li	a4,99
 80a:	0ee78c63          	beq	a5,a4,902 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 80e:	11478663          	beq	a5,s4,91a <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 812:	85d2                	mv	a1,s4
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	de6080e7          	jalr	-538(ra) # 5fc <putc>
        putc(fd, c);
 81e:	85a6                	mv	a1,s1
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	dda080e7          	jalr	-550(ra) # 5fc <putc>
      }
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b765                	j	7d4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 82e:	008b0493          	addi	s1,s6,8
 832:	4685                	li	a3,1
 834:	4629                	li	a2,10
 836:	000b2583          	lw	a1,0(s6)
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	e46080e7          	jalr	-442(ra) # 682 <printint>
 844:	8b26                	mv	s6,s1
      state = 0;
 846:	4981                	li	s3,0
 848:	b771                	j	7d4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 84a:	008b0493          	addi	s1,s6,8
 84e:	4681                	li	a3,0
 850:	4629                	li	a2,10
 852:	000b2583          	lw	a1,0(s6)
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	e2a080e7          	jalr	-470(ra) # 682 <printint>
 860:	8b26                	mv	s6,s1
      state = 0;
 862:	4981                	li	s3,0
 864:	bf85                	j	7d4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 866:	008b0493          	addi	s1,s6,8
 86a:	4681                	li	a3,0
 86c:	4641                	li	a2,16
 86e:	000b2583          	lw	a1,0(s6)
 872:	8556                	mv	a0,s5
 874:	00000097          	auipc	ra,0x0
 878:	e0e080e7          	jalr	-498(ra) # 682 <printint>
 87c:	8b26                	mv	s6,s1
      state = 0;
 87e:	4981                	li	s3,0
 880:	bf91                	j	7d4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 882:	008b0793          	addi	a5,s6,8
 886:	f8f43423          	sd	a5,-120(s0)
 88a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 88e:	03000593          	li	a1,48
 892:	8556                	mv	a0,s5
 894:	00000097          	auipc	ra,0x0
 898:	d68080e7          	jalr	-664(ra) # 5fc <putc>
  putc(fd, 'x');
 89c:	85ea                	mv	a1,s10
 89e:	8556                	mv	a0,s5
 8a0:	00000097          	auipc	ra,0x0
 8a4:	d5c080e7          	jalr	-676(ra) # 5fc <putc>
 8a8:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8aa:	03c9d793          	srli	a5,s3,0x3c
 8ae:	97de                	add	a5,a5,s7
 8b0:	0007c583          	lbu	a1,0(a5)
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	d46080e7          	jalr	-698(ra) # 5fc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8be:	0992                	slli	s3,s3,0x4
 8c0:	34fd                	addiw	s1,s1,-1
 8c2:	f4e5                	bnez	s1,8aa <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8c4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	b729                	j	7d4 <vprintf+0x60>
        s = va_arg(ap, char*);
 8cc:	008b0993          	addi	s3,s6,8
 8d0:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 8d4:	c085                	beqz	s1,8f4 <vprintf+0x180>
        while(*s != 0){
 8d6:	0004c583          	lbu	a1,0(s1)
 8da:	c9a1                	beqz	a1,92a <vprintf+0x1b6>
          putc(fd, *s);
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	d1e080e7          	jalr	-738(ra) # 5fc <putc>
          s++;
 8e6:	0485                	addi	s1,s1,1
        while(*s != 0){
 8e8:	0004c583          	lbu	a1,0(s1)
 8ec:	f9e5                	bnez	a1,8dc <vprintf+0x168>
        s = va_arg(ap, char*);
 8ee:	8b4e                	mv	s6,s3
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	b5cd                	j	7d4 <vprintf+0x60>
          s = "(null)";
 8f4:	00000497          	auipc	s1,0x0
 8f8:	27448493          	addi	s1,s1,628 # b68 <digits+0x18>
        while(*s != 0){
 8fc:	02800593          	li	a1,40
 900:	bff1                	j	8dc <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 902:	008b0493          	addi	s1,s6,8
 906:	000b4583          	lbu	a1,0(s6)
 90a:	8556                	mv	a0,s5
 90c:	00000097          	auipc	ra,0x0
 910:	cf0080e7          	jalr	-784(ra) # 5fc <putc>
 914:	8b26                	mv	s6,s1
      state = 0;
 916:	4981                	li	s3,0
 918:	bd75                	j	7d4 <vprintf+0x60>
        putc(fd, c);
 91a:	85d2                	mv	a1,s4
 91c:	8556                	mv	a0,s5
 91e:	00000097          	auipc	ra,0x0
 922:	cde080e7          	jalr	-802(ra) # 5fc <putc>
      state = 0;
 926:	4981                	li	s3,0
 928:	b575                	j	7d4 <vprintf+0x60>
        s = va_arg(ap, char*);
 92a:	8b4e                	mv	s6,s3
      state = 0;
 92c:	4981                	li	s3,0
 92e:	b55d                	j	7d4 <vprintf+0x60>
    }
  }
}
 930:	70e6                	ld	ra,120(sp)
 932:	7446                	ld	s0,112(sp)
 934:	74a6                	ld	s1,104(sp)
 936:	7906                	ld	s2,96(sp)
 938:	69e6                	ld	s3,88(sp)
 93a:	6a46                	ld	s4,80(sp)
 93c:	6aa6                	ld	s5,72(sp)
 93e:	6b06                	ld	s6,64(sp)
 940:	7be2                	ld	s7,56(sp)
 942:	7c42                	ld	s8,48(sp)
 944:	7ca2                	ld	s9,40(sp)
 946:	7d02                	ld	s10,32(sp)
 948:	6de2                	ld	s11,24(sp)
 94a:	6109                	addi	sp,sp,128
 94c:	8082                	ret

000000000000094e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 94e:	715d                	addi	sp,sp,-80
 950:	ec06                	sd	ra,24(sp)
 952:	e822                	sd	s0,16(sp)
 954:	1000                	addi	s0,sp,32
 956:	e010                	sd	a2,0(s0)
 958:	e414                	sd	a3,8(s0)
 95a:	e818                	sd	a4,16(s0)
 95c:	ec1c                	sd	a5,24(s0)
 95e:	03043023          	sd	a6,32(s0)
 962:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 966:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 96a:	8622                	mv	a2,s0
 96c:	00000097          	auipc	ra,0x0
 970:	e08080e7          	jalr	-504(ra) # 774 <vprintf>
}
 974:	60e2                	ld	ra,24(sp)
 976:	6442                	ld	s0,16(sp)
 978:	6161                	addi	sp,sp,80
 97a:	8082                	ret

000000000000097c <printf>:

void
printf(const char *fmt, ...)
{
 97c:	711d                	addi	sp,sp,-96
 97e:	ec06                	sd	ra,24(sp)
 980:	e822                	sd	s0,16(sp)
 982:	1000                	addi	s0,sp,32
 984:	e40c                	sd	a1,8(s0)
 986:	e810                	sd	a2,16(s0)
 988:	ec14                	sd	a3,24(s0)
 98a:	f018                	sd	a4,32(s0)
 98c:	f41c                	sd	a5,40(s0)
 98e:	03043823          	sd	a6,48(s0)
 992:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 996:	00840613          	addi	a2,s0,8
 99a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 99e:	85aa                	mv	a1,a0
 9a0:	4505                	li	a0,1
 9a2:	00000097          	auipc	ra,0x0
 9a6:	dd2080e7          	jalr	-558(ra) # 774 <vprintf>
}
 9aa:	60e2                	ld	ra,24(sp)
 9ac:	6442                	ld	s0,16(sp)
 9ae:	6125                	addi	sp,sp,96
 9b0:	8082                	ret

00000000000009b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9b2:	1141                	addi	sp,sp,-16
 9b4:	e422                	sd	s0,8(sp)
 9b6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9b8:	ff050693          	addi	a3,a0,-16 # ff0 <putc_index+0x148>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9bc:	00000797          	auipc	a5,0x0
 9c0:	1c478793          	addi	a5,a5,452 # b80 <freep>
 9c4:	639c                	ld	a5,0(a5)
 9c6:	a805                	j	9f6 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9c8:	4618                	lw	a4,8(a2)
 9ca:	9db9                	addw	a1,a1,a4
 9cc:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9d0:	6398                	ld	a4,0(a5)
 9d2:	6318                	ld	a4,0(a4)
 9d4:	fee53823          	sd	a4,-16(a0)
 9d8:	a091                	j	a1c <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9da:	ff852703          	lw	a4,-8(a0)
 9de:	9e39                	addw	a2,a2,a4
 9e0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9e2:	ff053703          	ld	a4,-16(a0)
 9e6:	e398                	sd	a4,0(a5)
 9e8:	a099                	j	a2e <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ea:	6398                	ld	a4,0(a5)
 9ec:	00e7e463          	bltu	a5,a4,9f4 <free+0x42>
 9f0:	00e6ea63          	bltu	a3,a4,a04 <free+0x52>
{
 9f4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f6:	fed7fae3          	bleu	a3,a5,9ea <free+0x38>
 9fa:	6398                	ld	a4,0(a5)
 9fc:	00e6e463          	bltu	a3,a4,a04 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a00:	fee7eae3          	bltu	a5,a4,9f4 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 a04:	ff852583          	lw	a1,-8(a0)
 a08:	6390                	ld	a2,0(a5)
 a0a:	02059713          	slli	a4,a1,0x20
 a0e:	9301                	srli	a4,a4,0x20
 a10:	0712                	slli	a4,a4,0x4
 a12:	9736                	add	a4,a4,a3
 a14:	fae60ae3          	beq	a2,a4,9c8 <free+0x16>
    bp->s.ptr = p->s.ptr;
 a18:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a1c:	4790                	lw	a2,8(a5)
 a1e:	02061713          	slli	a4,a2,0x20
 a22:	9301                	srli	a4,a4,0x20
 a24:	0712                	slli	a4,a4,0x4
 a26:	973e                	add	a4,a4,a5
 a28:	fae689e3          	beq	a3,a4,9da <free+0x28>
  } else
    p->s.ptr = bp;
 a2c:	e394                	sd	a3,0(a5)
  freep = p;
 a2e:	00000717          	auipc	a4,0x0
 a32:	14f73923          	sd	a5,338(a4) # b80 <freep>
}
 a36:	6422                	ld	s0,8(sp)
 a38:	0141                	addi	sp,sp,16
 a3a:	8082                	ret

0000000000000a3c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a3c:	7139                	addi	sp,sp,-64
 a3e:	fc06                	sd	ra,56(sp)
 a40:	f822                	sd	s0,48(sp)
 a42:	f426                	sd	s1,40(sp)
 a44:	f04a                	sd	s2,32(sp)
 a46:	ec4e                	sd	s3,24(sp)
 a48:	e852                	sd	s4,16(sp)
 a4a:	e456                	sd	s5,8(sp)
 a4c:	e05a                	sd	s6,0(sp)
 a4e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a50:	02051993          	slli	s3,a0,0x20
 a54:	0209d993          	srli	s3,s3,0x20
 a58:	09bd                	addi	s3,s3,15
 a5a:	0049d993          	srli	s3,s3,0x4
 a5e:	2985                	addiw	s3,s3,1
 a60:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 a64:	00000797          	auipc	a5,0x0
 a68:	11c78793          	addi	a5,a5,284 # b80 <freep>
 a6c:	6388                	ld	a0,0(a5)
 a6e:	c515                	beqz	a0,a9a <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a70:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a72:	4798                	lw	a4,8(a5)
 a74:	03277f63          	bleu	s2,a4,ab2 <malloc+0x76>
 a78:	8a4e                	mv	s4,s3
 a7a:	0009871b          	sext.w	a4,s3
 a7e:	6685                	lui	a3,0x1
 a80:	00d77363          	bleu	a3,a4,a86 <malloc+0x4a>
 a84:	6a05                	lui	s4,0x1
 a86:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 a8a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a8e:	00000497          	auipc	s1,0x0
 a92:	0f248493          	addi	s1,s1,242 # b80 <freep>
  if(p == (char*)-1)
 a96:	5b7d                	li	s6,-1
 a98:	a885                	j	b08 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a9a:	00000797          	auipc	a5,0x0
 a9e:	59e78793          	addi	a5,a5,1438 # 1038 <base>
 aa2:	00000717          	auipc	a4,0x0
 aa6:	0cf73f23          	sd	a5,222(a4) # b80 <freep>
 aaa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 aac:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ab0:	b7e1                	j	a78 <malloc+0x3c>
      if(p->s.size == nunits)
 ab2:	02e90b63          	beq	s2,a4,ae8 <malloc+0xac>
        p->s.size -= nunits;
 ab6:	4137073b          	subw	a4,a4,s3
 aba:	c798                	sw	a4,8(a5)
        p += p->s.size;
 abc:	1702                	slli	a4,a4,0x20
 abe:	9301                	srli	a4,a4,0x20
 ac0:	0712                	slli	a4,a4,0x4
 ac2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ac4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ac8:	00000717          	auipc	a4,0x0
 acc:	0aa73c23          	sd	a0,184(a4) # b80 <freep>
      return (void*)(p + 1);
 ad0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ad4:	70e2                	ld	ra,56(sp)
 ad6:	7442                	ld	s0,48(sp)
 ad8:	74a2                	ld	s1,40(sp)
 ada:	7902                	ld	s2,32(sp)
 adc:	69e2                	ld	s3,24(sp)
 ade:	6a42                	ld	s4,16(sp)
 ae0:	6aa2                	ld	s5,8(sp)
 ae2:	6b02                	ld	s6,0(sp)
 ae4:	6121                	addi	sp,sp,64
 ae6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ae8:	6398                	ld	a4,0(a5)
 aea:	e118                	sd	a4,0(a0)
 aec:	bff1                	j	ac8 <malloc+0x8c>
  hp->s.size = nu;
 aee:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 af2:	0541                	addi	a0,a0,16
 af4:	00000097          	auipc	ra,0x0
 af8:	ebe080e7          	jalr	-322(ra) # 9b2 <free>
  return freep;
 afc:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 afe:	d979                	beqz	a0,ad4 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b00:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b02:	4798                	lw	a4,8(a5)
 b04:	fb2777e3          	bleu	s2,a4,ab2 <malloc+0x76>
    if(p == freep)
 b08:	6098                	ld	a4,0(s1)
 b0a:	853e                	mv	a0,a5
 b0c:	fef71ae3          	bne	a4,a5,b00 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 b10:	8552                	mv	a0,s4
 b12:	00000097          	auipc	ra,0x0
 b16:	a5c080e7          	jalr	-1444(ra) # 56e <sbrk>
  if(p == (char*)-1)
 b1a:	fd651ae3          	bne	a0,s6,aee <malloc+0xb2>
        return 0;
 b1e:	4501                	li	a0,0
 b20:	bf55                	j	ad4 <malloc+0x98>
