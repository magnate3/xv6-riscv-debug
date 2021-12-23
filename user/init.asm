
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <make_consoleX>:
#include "kernel/fcntl.h"


char consoleX[] = "consoleX";

char* make_consoleX(int i){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  if(i < 1 || i > 9){
   e:	fff5071b          	addiw	a4,a0,-1
  12:	47a1                	li	a5,8
  14:	04e7e363          	bltu	a5,a4,5a <make_consoleX+0x5a>
  18:	84aa                	mv	s1,a0
    printf("Console number can not be more than 9.\n");
    exit(1);
  }
  int l = strlen(consoleX);
  1a:	00001997          	auipc	s3,0x1
  1e:	b4e98993          	addi	s3,s3,-1202 # b68 <consoleX>
  22:	854e                	mv	a0,s3
  24:	00000097          	auipc	ra,0x0
  28:	1dc080e7          	jalr	476(ra) # 200 <strlen>
  char* str = malloc(l+1);
  2c:	2505                	addiw	a0,a0,1
  2e:	00001097          	auipc	ra,0x1
  32:	9b6080e7          	jalr	-1610(ra) # 9e4 <malloc>
  36:	892a                	mv	s2,a0
  strcpy(str, consoleX);
  38:	85ce                	mv	a1,s3
  3a:	00000097          	auipc	ra,0x0
  3e:	176080e7          	jalr	374(ra) # 1b0 <strcpy>
  str[7] = '0' + i;
  42:	0304849b          	addiw	s1,s1,48
  46:	009903a3          	sb	s1,7(s2)
  return str;
}
  4a:	854a                	mv	a0,s2
  4c:	70a2                	ld	ra,40(sp)
  4e:	7402                	ld	s0,32(sp)
  50:	64e2                	ld	s1,24(sp)
  52:	6942                	ld	s2,16(sp)
  54:	69a2                	ld	s3,8(sp)
  56:	6145                	addi	sp,sp,48
  58:	8082                	ret
    printf("Console number can not be more than 9.\n");
  5a:	00001517          	auipc	a0,0x1
  5e:	a7650513          	addi	a0,a0,-1418 # ad0 <malloc+0xec>
  62:	00001097          	auipc	ra,0x1
  66:	8c2080e7          	jalr	-1854(ra) # 924 <printf>
    exit(1);
  6a:	4505                	li	a0,1
  6c:	00000097          	auipc	ra,0x0
  70:	422080e7          	jalr	1058(ra) # 48e <exit>

0000000000000074 <shloop>:


char *argv[] = { "sh", 0, 0 };

void shloop(int cur_console){
  74:	7179                	addi	sp,sp,-48
  76:	f406                	sd	ra,40(sp)
  78:	f022                	sd	s0,32(sp)
  7a:	ec26                	sd	s1,24(sp)
  7c:	e84a                	sd	s2,16(sp)
  7e:	e44e                	sd	s3,8(sp)
  80:	1800                	addi	s0,sp,48
  82:	84aa                	mv	s1,a0

  char* cons = make_consoleX(cur_console);
  84:	00000097          	auipc	ra,0x0
  88:	f7c080e7          	jalr	-132(ra) # 0 <make_consoleX>
  8c:	89aa                	mv	s3,a0
  int fd;
  if((fd = open(cons, O_RDWR)) < 0){
  8e:	4589                	li	a1,2
  90:	00000097          	auipc	ra,0x0
  94:	43e080e7          	jalr	1086(ra) # 4ce <open>
  98:	04054763          	bltz	a0,e6 <shloop+0x72>
    mknod(cons, 1, cur_console);
    fd = open(cons, O_RDWR);
  }
  dup(0);  // stdout
  9c:	4501                	li	a0,0
  9e:	00000097          	auipc	ra,0x0
  a2:	468080e7          	jalr	1128(ra) # 506 <dup>
  dup(0);  // stderr
  a6:	4501                	li	a0,0
  a8:	00000097          	auipc	ra,0x0
  ac:	45e080e7          	jalr	1118(ra) # 506 <dup>
  int pid, wpid;

  for(;;){
    printf("init: starting sh\n");
  b0:	00001917          	auipc	s2,0x1
  b4:	a4890913          	addi	s2,s2,-1464 # af8 <malloc+0x114>
  b8:	854a                	mv	a0,s2
  ba:	00001097          	auipc	ra,0x1
  be:	86a080e7          	jalr	-1942(ra) # 924 <printf>
    pid = fork();
  c2:	00000097          	auipc	ra,0x0
  c6:	3c4080e7          	jalr	964(ra) # 486 <fork>
  ca:	84aa                	mv	s1,a0
    if(pid < 0){
  cc:	02054e63          	bltz	a0,108 <shloop+0x94>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  d0:	c929                	beqz	a0,122 <shloop+0xae>
      argv[1] = cons;
      exec("sh", argv);
      printf("init: exec sh failed\n");
      exit(1);
    }
    while((wpid=wait(0)) >= 0 && wpid != pid){
  d2:	4501                	li	a0,0
  d4:	00000097          	auipc	ra,0x0
  d8:	3c2080e7          	jalr	962(ra) # 496 <wait>
  dc:	fc054ee3          	bltz	a0,b8 <shloop+0x44>
  e0:	fea499e3          	bne	s1,a0,d2 <shloop+0x5e>
  e4:	bfd1                	j	b8 <shloop+0x44>
    mknod(cons, 1, cur_console);
  e6:	0104961b          	slliw	a2,s1,0x10
  ea:	4106561b          	sraiw	a2,a2,0x10
  ee:	4585                	li	a1,1
  f0:	854e                	mv	a0,s3
  f2:	00000097          	auipc	ra,0x0
  f6:	3e4080e7          	jalr	996(ra) # 4d6 <mknod>
    fd = open(cons, O_RDWR);
  fa:	4589                	li	a1,2
  fc:	854e                	mv	a0,s3
  fe:	00000097          	auipc	ra,0x0
 102:	3d0080e7          	jalr	976(ra) # 4ce <open>
 106:	bf59                	j	9c <shloop+0x28>
      printf("init: fork failed\n");
 108:	00001517          	auipc	a0,0x1
 10c:	a0850513          	addi	a0,a0,-1528 # b10 <malloc+0x12c>
 110:	00001097          	auipc	ra,0x1
 114:	814080e7          	jalr	-2028(ra) # 924 <printf>
      exit(1);
 118:	4505                	li	a0,1
 11a:	00000097          	auipc	ra,0x0
 11e:	374080e7          	jalr	884(ra) # 48e <exit>
      argv[1] = cons;
 122:	00001797          	auipc	a5,0x1
 126:	a537bf23          	sd	s3,-1442(a5) # b80 <argv+0x8>
      exec("sh", argv);
 12a:	00001597          	auipc	a1,0x1
 12e:	a4e58593          	addi	a1,a1,-1458 # b78 <argv>
 132:	00001517          	auipc	a0,0x1
 136:	9f650513          	addi	a0,a0,-1546 # b28 <malloc+0x144>
 13a:	00000097          	auipc	ra,0x0
 13e:	38c080e7          	jalr	908(ra) # 4c6 <exec>
      printf("init: exec sh failed\n");
 142:	00001517          	auipc	a0,0x1
 146:	9ee50513          	addi	a0,a0,-1554 # b30 <malloc+0x14c>
 14a:	00000097          	auipc	ra,0x0
 14e:	7da080e7          	jalr	2010(ra) # 924 <printf>
      exit(1);
 152:	4505                	li	a0,1
 154:	00000097          	auipc	ra,0x0
 158:	33a080e7          	jalr	826(ra) # 48e <exit>

000000000000015c <main>:

}

int
main(void)
{
 15c:	1101                	addi	sp,sp,-32
 15e:	ec06                	sd	ra,24(sp)
 160:	e822                	sd	s0,16(sp)
 162:	e426                	sd	s1,8(sp)
 164:	e04a                	sd	s2,0(sp)
 166:	1000                	addi	s0,sp,32
  int nb_consoles = 3;

  int cur_console = 0;
  int pid;

  while(cur_console++ < nb_consoles){
 168:	4485                	li	s1,1
 16a:	4911                	li	s2,4
    pid = fork();
 16c:	00000097          	auipc	ra,0x0
 170:	31a080e7          	jalr	794(ra) # 486 <fork>
    if (pid < 0){
 174:	00054c63          	bltz	a0,18c <main+0x30>
      printf("init: fork failed\n");
      exit(1);
    }
    if (pid == 0){
 178:	c51d                	beqz	a0,1a6 <main+0x4a>
  while(cur_console++ < nb_consoles){
 17a:	2485                	addiw	s1,s1,1
 17c:	ff2498e3          	bne	s1,s2,16c <main+0x10>
      shloop(cur_console);
      return 1;
    }
  }
  while(1) wait(0);
 180:	4501                	li	a0,0
 182:	00000097          	auipc	ra,0x0
 186:	314080e7          	jalr	788(ra) # 496 <wait>
 18a:	bfdd                	j	180 <main+0x24>
      printf("init: fork failed\n");
 18c:	00001517          	auipc	a0,0x1
 190:	98450513          	addi	a0,a0,-1660 # b10 <malloc+0x12c>
 194:	00000097          	auipc	ra,0x0
 198:	790080e7          	jalr	1936(ra) # 924 <printf>
      exit(1);
 19c:	4505                	li	a0,1
 19e:	00000097          	auipc	ra,0x0
 1a2:	2f0080e7          	jalr	752(ra) # 48e <exit>
      shloop(cur_console);
 1a6:	8526                	mv	a0,s1
 1a8:	00000097          	auipc	ra,0x0
 1ac:	ecc080e7          	jalr	-308(ra) # 74 <shloop>

00000000000001b0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1b0:	1141                	addi	sp,sp,-16
 1b2:	e422                	sd	s0,8(sp)
 1b4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b6:	87aa                	mv	a5,a0
 1b8:	0585                	addi	a1,a1,1
 1ba:	0785                	addi	a5,a5,1
 1bc:	fff5c703          	lbu	a4,-1(a1)
 1c0:	fee78fa3          	sb	a4,-1(a5)
 1c4:	fb75                	bnez	a4,1b8 <strcpy+0x8>
    ;
  return os;
}
 1c6:	6422                	ld	s0,8(sp)
 1c8:	0141                	addi	sp,sp,16
 1ca:	8082                	ret

00000000000001cc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	cf91                	beqz	a5,1f2 <strcmp+0x26>
 1d8:	0005c703          	lbu	a4,0(a1)
 1dc:	00f71b63          	bne	a4,a5,1f2 <strcmp+0x26>
    p++, q++;
 1e0:	0505                	addi	a0,a0,1
 1e2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	c789                	beqz	a5,1f2 <strcmp+0x26>
 1ea:	0005c703          	lbu	a4,0(a1)
 1ee:	fef709e3          	beq	a4,a5,1e0 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 1f2:	0005c503          	lbu	a0,0(a1)
}
 1f6:	40a7853b          	subw	a0,a5,a0
 1fa:	6422                	ld	s0,8(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret

0000000000000200 <strlen>:

uint
strlen(const char *s)
{
 200:	1141                	addi	sp,sp,-16
 202:	e422                	sd	s0,8(sp)
 204:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 206:	00054783          	lbu	a5,0(a0)
 20a:	cf91                	beqz	a5,226 <strlen+0x26>
 20c:	0505                	addi	a0,a0,1
 20e:	87aa                	mv	a5,a0
 210:	4685                	li	a3,1
 212:	9e89                	subw	a3,a3,a0
 214:	00f6853b          	addw	a0,a3,a5
 218:	0785                	addi	a5,a5,1
 21a:	fff7c703          	lbu	a4,-1(a5)
 21e:	fb7d                	bnez	a4,214 <strlen+0x14>
    ;
  return n;
}
 220:	6422                	ld	s0,8(sp)
 222:	0141                	addi	sp,sp,16
 224:	8082                	ret
  for(n = 0; s[n]; n++)
 226:	4501                	li	a0,0
 228:	bfe5                	j	220 <strlen+0x20>

000000000000022a <memset>:

void*
memset(void *dst, int c, uint n)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e422                	sd	s0,8(sp)
 22e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 230:	ce09                	beqz	a2,24a <memset+0x20>
 232:	87aa                	mv	a5,a0
 234:	fff6071b          	addiw	a4,a2,-1
 238:	1702                	slli	a4,a4,0x20
 23a:	9301                	srli	a4,a4,0x20
 23c:	0705                	addi	a4,a4,1
 23e:	972a                	add	a4,a4,a0
    cdst[i] = c;
 240:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 244:	0785                	addi	a5,a5,1
 246:	fee79de3          	bne	a5,a4,240 <memset+0x16>
  }
  return dst;
}
 24a:	6422                	ld	s0,8(sp)
 24c:	0141                	addi	sp,sp,16
 24e:	8082                	ret

0000000000000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	1141                	addi	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	addi	s0,sp,16
  for(; *s; s++)
 256:	00054783          	lbu	a5,0(a0)
 25a:	cf91                	beqz	a5,276 <strchr+0x26>
    if(*s == c)
 25c:	00f58a63          	beq	a1,a5,270 <strchr+0x20>
  for(; *s; s++)
 260:	0505                	addi	a0,a0,1
 262:	00054783          	lbu	a5,0(a0)
 266:	c781                	beqz	a5,26e <strchr+0x1e>
    if(*s == c)
 268:	feb79ce3          	bne	a5,a1,260 <strchr+0x10>
 26c:	a011                	j	270 <strchr+0x20>
      return (char*)s;
  return 0;
 26e:	4501                	li	a0,0
}
 270:	6422                	ld	s0,8(sp)
 272:	0141                	addi	sp,sp,16
 274:	8082                	ret
  return 0;
 276:	4501                	li	a0,0
 278:	bfe5                	j	270 <strchr+0x20>

000000000000027a <gets>:

char*
gets(char *buf, int max)
{
 27a:	711d                	addi	sp,sp,-96
 27c:	ec86                	sd	ra,88(sp)
 27e:	e8a2                	sd	s0,80(sp)
 280:	e4a6                	sd	s1,72(sp)
 282:	e0ca                	sd	s2,64(sp)
 284:	fc4e                	sd	s3,56(sp)
 286:	f852                	sd	s4,48(sp)
 288:	f456                	sd	s5,40(sp)
 28a:	f05a                	sd	s6,32(sp)
 28c:	ec5e                	sd	s7,24(sp)
 28e:	1080                	addi	s0,sp,96
 290:	8baa                	mv	s7,a0
 292:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 294:	892a                	mv	s2,a0
 296:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 298:	4aa9                	li	s5,10
 29a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 29c:	0019849b          	addiw	s1,s3,1
 2a0:	0344d863          	ble	s4,s1,2d0 <gets+0x56>
    cc = read(0, &c, 1);
 2a4:	4605                	li	a2,1
 2a6:	faf40593          	addi	a1,s0,-81
 2aa:	4501                	li	a0,0
 2ac:	00000097          	auipc	ra,0x0
 2b0:	1fa080e7          	jalr	506(ra) # 4a6 <read>
    if(cc < 1)
 2b4:	00a05e63          	blez	a0,2d0 <gets+0x56>
    buf[i++] = c;
 2b8:	faf44783          	lbu	a5,-81(s0)
 2bc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2c0:	01578763          	beq	a5,s5,2ce <gets+0x54>
 2c4:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 2c6:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 2c8:	fd679ae3          	bne	a5,s6,29c <gets+0x22>
 2cc:	a011                	j	2d0 <gets+0x56>
  for(i=0; i+1 < max; ){
 2ce:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2d0:	99de                	add	s3,s3,s7
 2d2:	00098023          	sb	zero,0(s3)
  return buf;
}
 2d6:	855e                	mv	a0,s7
 2d8:	60e6                	ld	ra,88(sp)
 2da:	6446                	ld	s0,80(sp)
 2dc:	64a6                	ld	s1,72(sp)
 2de:	6906                	ld	s2,64(sp)
 2e0:	79e2                	ld	s3,56(sp)
 2e2:	7a42                	ld	s4,48(sp)
 2e4:	7aa2                	ld	s5,40(sp)
 2e6:	7b02                	ld	s6,32(sp)
 2e8:	6be2                	ld	s7,24(sp)
 2ea:	6125                	addi	sp,sp,96
 2ec:	8082                	ret

00000000000002ee <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f4:	00054683          	lbu	a3,0(a0)
 2f8:	fd06879b          	addiw	a5,a3,-48
 2fc:	0ff7f793          	andi	a5,a5,255
 300:	4725                	li	a4,9
 302:	02f76963          	bltu	a4,a5,334 <atoi+0x46>
 306:	862a                	mv	a2,a0
  n = 0;
 308:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 30a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 30c:	0605                	addi	a2,a2,1
 30e:	0025179b          	slliw	a5,a0,0x2
 312:	9fa9                	addw	a5,a5,a0
 314:	0017979b          	slliw	a5,a5,0x1
 318:	9fb5                	addw	a5,a5,a3
 31a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 31e:	00064683          	lbu	a3,0(a2)
 322:	fd06871b          	addiw	a4,a3,-48
 326:	0ff77713          	andi	a4,a4,255
 32a:	fee5f1e3          	bleu	a4,a1,30c <atoi+0x1e>
  return n;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  n = 0;
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <atoi+0x40>

0000000000000338 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 33e:	02b57663          	bleu	a1,a0,36a <memmove+0x32>
    while(n-- > 0)
 342:	02c05163          	blez	a2,364 <memmove+0x2c>
 346:	fff6079b          	addiw	a5,a2,-1
 34a:	1782                	slli	a5,a5,0x20
 34c:	9381                	srli	a5,a5,0x20
 34e:	0785                	addi	a5,a5,1
 350:	97aa                	add	a5,a5,a0
  dst = vdst;
 352:	872a                	mv	a4,a0
      *dst++ = *src++;
 354:	0585                	addi	a1,a1,1
 356:	0705                	addi	a4,a4,1
 358:	fff5c683          	lbu	a3,-1(a1)
 35c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 360:	fee79ae3          	bne	a5,a4,354 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
    dst += n;
 36a:	00c50733          	add	a4,a0,a2
    src += n;
 36e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 370:	fec05ae3          	blez	a2,364 <memmove+0x2c>
 374:	fff6079b          	addiw	a5,a2,-1
 378:	1782                	slli	a5,a5,0x20
 37a:	9381                	srli	a5,a5,0x20
 37c:	fff7c793          	not	a5,a5
 380:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 382:	15fd                	addi	a1,a1,-1
 384:	177d                	addi	a4,a4,-1
 386:	0005c683          	lbu	a3,0(a1)
 38a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 38e:	fef71ae3          	bne	a4,a5,382 <memmove+0x4a>
 392:	bfc9                	j	364 <memmove+0x2c>

0000000000000394 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 394:	1141                	addi	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 39a:	ce15                	beqz	a2,3d6 <memcmp+0x42>
 39c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	0005c703          	lbu	a4,0(a1)
 3a8:	02e79063          	bne	a5,a4,3c8 <memcmp+0x34>
 3ac:	1682                	slli	a3,a3,0x20
 3ae:	9281                	srli	a3,a3,0x20
 3b0:	0685                	addi	a3,a3,1
 3b2:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 3b4:	0505                	addi	a0,a0,1
    p2++;
 3b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3b8:	00d50d63          	beq	a0,a3,3d2 <memcmp+0x3e>
    if (*p1 != *p2) {
 3bc:	00054783          	lbu	a5,0(a0)
 3c0:	0005c703          	lbu	a4,0(a1)
 3c4:	fee788e3          	beq	a5,a4,3b4 <memcmp+0x20>
      return *p1 - *p2;
 3c8:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 3cc:	6422                	ld	s0,8(sp)
 3ce:	0141                	addi	sp,sp,16
 3d0:	8082                	ret
  return 0;
 3d2:	4501                	li	a0,0
 3d4:	bfe5                	j	3cc <memcmp+0x38>
 3d6:	4501                	li	a0,0
 3d8:	bfd5                	j	3cc <memcmp+0x38>

00000000000003da <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3da:	1141                	addi	sp,sp,-16
 3dc:	e406                	sd	ra,8(sp)
 3de:	e022                	sd	s0,0(sp)
 3e0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3e2:	00000097          	auipc	ra,0x0
 3e6:	f56080e7          	jalr	-170(ra) # 338 <memmove>
}
 3ea:	60a2                	ld	ra,8(sp)
 3ec:	6402                	ld	s0,0(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret

00000000000003f2 <close>:

int close(int fd){
 3f2:	1101                	addi	sp,sp,-32
 3f4:	ec06                	sd	ra,24(sp)
 3f6:	e822                	sd	s0,16(sp)
 3f8:	e426                	sd	s1,8(sp)
 3fa:	1000                	addi	s0,sp,32
 3fc:	84aa                	mv	s1,a0
  fflush(fd);
 3fe:	00000097          	auipc	ra,0x0
 402:	2da080e7          	jalr	730(ra) # 6d8 <fflush>
  char* buf = get_putc_buf(fd);
 406:	8526                	mv	a0,s1
 408:	00000097          	auipc	ra,0x0
 40c:	14e080e7          	jalr	334(ra) # 556 <get_putc_buf>
  if(buf){
 410:	cd11                	beqz	a0,42c <close+0x3a>
    free(buf);
 412:	00000097          	auipc	ra,0x0
 416:	548080e7          	jalr	1352(ra) # 95a <free>
    putc_buf[fd] = 0;
 41a:	00349713          	slli	a4,s1,0x3
 41e:	00000797          	auipc	a5,0x0
 422:	77a78793          	addi	a5,a5,1914 # b98 <putc_buf>
 426:	97ba                	add	a5,a5,a4
 428:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 42c:	8526                	mv	a0,s1
 42e:	00000097          	auipc	ra,0x0
 432:	088080e7          	jalr	136(ra) # 4b6 <sclose>
}
 436:	60e2                	ld	ra,24(sp)
 438:	6442                	ld	s0,16(sp)
 43a:	64a2                	ld	s1,8(sp)
 43c:	6105                	addi	sp,sp,32
 43e:	8082                	ret

0000000000000440 <stat>:
{
 440:	1101                	addi	sp,sp,-32
 442:	ec06                	sd	ra,24(sp)
 444:	e822                	sd	s0,16(sp)
 446:	e426                	sd	s1,8(sp)
 448:	e04a                	sd	s2,0(sp)
 44a:	1000                	addi	s0,sp,32
 44c:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 44e:	4581                	li	a1,0
 450:	00000097          	auipc	ra,0x0
 454:	07e080e7          	jalr	126(ra) # 4ce <open>
  if(fd < 0)
 458:	02054563          	bltz	a0,482 <stat+0x42>
 45c:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 45e:	85ca                	mv	a1,s2
 460:	00000097          	auipc	ra,0x0
 464:	086080e7          	jalr	134(ra) # 4e6 <fstat>
 468:	892a                	mv	s2,a0
  close(fd);
 46a:	8526                	mv	a0,s1
 46c:	00000097          	auipc	ra,0x0
 470:	f86080e7          	jalr	-122(ra) # 3f2 <close>
}
 474:	854a                	mv	a0,s2
 476:	60e2                	ld	ra,24(sp)
 478:	6442                	ld	s0,16(sp)
 47a:	64a2                	ld	s1,8(sp)
 47c:	6902                	ld	s2,0(sp)
 47e:	6105                	addi	sp,sp,32
 480:	8082                	ret
    return -1;
 482:	597d                	li	s2,-1
 484:	bfc5                	j	474 <stat+0x34>

0000000000000486 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 486:	4885                	li	a7,1
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <exit>:
.global exit
exit:
 li a7, SYS_exit
 48e:	4889                	li	a7,2
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <wait>:
.global wait
wait:
 li a7, SYS_wait
 496:	488d                	li	a7,3
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 49e:	4891                	li	a7,4
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <read>:
.global read
read:
 li a7, SYS_read
 4a6:	4895                	li	a7,5
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <write>:
.global write
write:
 li a7, SYS_write
 4ae:	48c1                	li	a7,16
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 4b6:	48d5                	li	a7,21
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <kill>:
.global kill
kill:
 li a7, SYS_kill
 4be:	4899                	li	a7,6
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4c6:	489d                	li	a7,7
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <open>:
.global open
open:
 li a7, SYS_open
 4ce:	48bd                	li	a7,15
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4d6:	48c5                	li	a7,17
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4de:	48c9                	li	a7,18
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4e6:	48a1                	li	a7,8
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <link>:
.global link
link:
 li a7, SYS_link
 4ee:	48cd                	li	a7,19
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4f6:	48d1                	li	a7,20
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4fe:	48a5                	li	a7,9
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <dup>:
.global dup
dup:
 li a7, SYS_dup
 506:	48a9                	li	a7,10
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 50e:	48ad                	li	a7,11
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 516:	48b1                	li	a7,12
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 51e:	48b5                	li	a7,13
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 526:	48b9                	li	a7,14
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 52e:	48d9                	li	a7,22
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <nice>:
.global nice
nice:
 li a7, SYS_nice
 536:	48dd                	li	a7,23
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 53e:	48e1                	li	a7,24
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 546:	48e5                	li	a7,25
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 54e:	48e9                	li	a7,26
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 556:	1101                	addi	sp,sp,-32
 558:	ec06                	sd	ra,24(sp)
 55a:	e822                	sd	s0,16(sp)
 55c:	e426                	sd	s1,8(sp)
 55e:	1000                	addi	s0,sp,32
 560:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 562:	00351693          	slli	a3,a0,0x3
 566:	00000797          	auipc	a5,0x0
 56a:	63278793          	addi	a5,a5,1586 # b98 <putc_buf>
 56e:	97b6                	add	a5,a5,a3
 570:	6388                	ld	a0,0(a5)
  if(buf) {
 572:	c511                	beqz	a0,57e <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 574:	60e2                	ld	ra,24(sp)
 576:	6442                	ld	s0,16(sp)
 578:	64a2                	ld	s1,8(sp)
 57a:	6105                	addi	sp,sp,32
 57c:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 57e:	6505                	lui	a0,0x1
 580:	00000097          	auipc	ra,0x0
 584:	464080e7          	jalr	1124(ra) # 9e4 <malloc>
  putc_buf[fd] = buf;
 588:	00000797          	auipc	a5,0x0
 58c:	61078793          	addi	a5,a5,1552 # b98 <putc_buf>
 590:	00349713          	slli	a4,s1,0x3
 594:	973e                	add	a4,a4,a5
 596:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 598:	00249713          	slli	a4,s1,0x2
 59c:	973e                	add	a4,a4,a5
 59e:	32072023          	sw	zero,800(a4)
  return buf;
 5a2:	bfc9                	j	574 <get_putc_buf+0x1e>

00000000000005a4 <putc>:

static void
putc(int fd, char c)
{
 5a4:	1101                	addi	sp,sp,-32
 5a6:	ec06                	sd	ra,24(sp)
 5a8:	e822                	sd	s0,16(sp)
 5aa:	e426                	sd	s1,8(sp)
 5ac:	e04a                	sd	s2,0(sp)
 5ae:	1000                	addi	s0,sp,32
 5b0:	84aa                	mv	s1,a0
 5b2:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 5b4:	00000097          	auipc	ra,0x0
 5b8:	fa2080e7          	jalr	-94(ra) # 556 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 5bc:	00249793          	slli	a5,s1,0x2
 5c0:	00000717          	auipc	a4,0x0
 5c4:	5d870713          	addi	a4,a4,1496 # b98 <putc_buf>
 5c8:	973e                	add	a4,a4,a5
 5ca:	32072783          	lw	a5,800(a4)
 5ce:	0017869b          	addiw	a3,a5,1
 5d2:	32d72023          	sw	a3,800(a4)
 5d6:	97aa                	add	a5,a5,a0
 5d8:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 5dc:	47a9                	li	a5,10
 5de:	02f90463          	beq	s2,a5,606 <putc+0x62>
 5e2:	00249713          	slli	a4,s1,0x2
 5e6:	00000797          	auipc	a5,0x0
 5ea:	5b278793          	addi	a5,a5,1458 # b98 <putc_buf>
 5ee:	97ba                	add	a5,a5,a4
 5f0:	3207a703          	lw	a4,800(a5)
 5f4:	6785                	lui	a5,0x1
 5f6:	00f70863          	beq	a4,a5,606 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 5fa:	60e2                	ld	ra,24(sp)
 5fc:	6442                	ld	s0,16(sp)
 5fe:	64a2                	ld	s1,8(sp)
 600:	6902                	ld	s2,0(sp)
 602:	6105                	addi	sp,sp,32
 604:	8082                	ret
    write(fd, buf, putc_index[fd]);
 606:	00249793          	slli	a5,s1,0x2
 60a:	00000917          	auipc	s2,0x0
 60e:	58e90913          	addi	s2,s2,1422 # b98 <putc_buf>
 612:	993e                	add	s2,s2,a5
 614:	32092603          	lw	a2,800(s2)
 618:	85aa                	mv	a1,a0
 61a:	8526                	mv	a0,s1
 61c:	00000097          	auipc	ra,0x0
 620:	e92080e7          	jalr	-366(ra) # 4ae <write>
    putc_index[fd] = 0;
 624:	32092023          	sw	zero,800(s2)
}
 628:	bfc9                	j	5fa <putc+0x56>

000000000000062a <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 62a:	7139                	addi	sp,sp,-64
 62c:	fc06                	sd	ra,56(sp)
 62e:	f822                	sd	s0,48(sp)
 630:	f426                	sd	s1,40(sp)
 632:	f04a                	sd	s2,32(sp)
 634:	ec4e                	sd	s3,24(sp)
 636:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 638:	c299                	beqz	a3,63e <printint+0x14>
 63a:	0005cd63          	bltz	a1,654 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 63e:	2581                	sext.w	a1,a1
  neg = 0;
 640:	4301                	li	t1,0
 642:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 646:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 648:	2601                	sext.w	a2,a2
 64a:	00000897          	auipc	a7,0x0
 64e:	4fe88893          	addi	a7,a7,1278 # b48 <digits>
 652:	a801                	j	662 <printint+0x38>
    x = -xx;
 654:	40b005bb          	negw	a1,a1
 658:	2581                	sext.w	a1,a1
    neg = 1;
 65a:	4305                	li	t1,1
    x = -xx;
 65c:	b7dd                	j	642 <printint+0x18>
  }while((x /= base) != 0);
 65e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 660:	8836                	mv	a6,a3
 662:	0018069b          	addiw	a3,a6,1
 666:	02c5f7bb          	remuw	a5,a1,a2
 66a:	1782                	slli	a5,a5,0x20
 66c:	9381                	srli	a5,a5,0x20
 66e:	97c6                	add	a5,a5,a7
 670:	0007c783          	lbu	a5,0(a5) # 1000 <putc_index+0x148>
 674:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 678:	0705                	addi	a4,a4,1
 67a:	02c5d7bb          	divuw	a5,a1,a2
 67e:	fec5f0e3          	bleu	a2,a1,65e <printint+0x34>
  if(neg)
 682:	00030b63          	beqz	t1,698 <printint+0x6e>
    buf[i++] = '-';
 686:	fd040793          	addi	a5,s0,-48
 68a:	96be                	add	a3,a3,a5
 68c:	02d00793          	li	a5,45
 690:	fef68823          	sb	a5,-16(a3)
 694:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 698:	02d05963          	blez	a3,6ca <printint+0xa0>
 69c:	89aa                	mv	s3,a0
 69e:	fc040793          	addi	a5,s0,-64
 6a2:	00d784b3          	add	s1,a5,a3
 6a6:	fff78913          	addi	s2,a5,-1
 6aa:	9936                	add	s2,s2,a3
 6ac:	36fd                	addiw	a3,a3,-1
 6ae:	1682                	slli	a3,a3,0x20
 6b0:	9281                	srli	a3,a3,0x20
 6b2:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 6b6:	fff4c583          	lbu	a1,-1(s1)
 6ba:	854e                	mv	a0,s3
 6bc:	00000097          	auipc	ra,0x0
 6c0:	ee8080e7          	jalr	-280(ra) # 5a4 <putc>
  while(--i >= 0)
 6c4:	14fd                	addi	s1,s1,-1
 6c6:	ff2498e3          	bne	s1,s2,6b6 <printint+0x8c>
}
 6ca:	70e2                	ld	ra,56(sp)
 6cc:	7442                	ld	s0,48(sp)
 6ce:	74a2                	ld	s1,40(sp)
 6d0:	7902                	ld	s2,32(sp)
 6d2:	69e2                	ld	s3,24(sp)
 6d4:	6121                	addi	sp,sp,64
 6d6:	8082                	ret

00000000000006d8 <fflush>:
void fflush(int fd){
 6d8:	1101                	addi	sp,sp,-32
 6da:	ec06                	sd	ra,24(sp)
 6dc:	e822                	sd	s0,16(sp)
 6de:	e426                	sd	s1,8(sp)
 6e0:	e04a                	sd	s2,0(sp)
 6e2:	1000                	addi	s0,sp,32
 6e4:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e70080e7          	jalr	-400(ra) # 556 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 6ee:	00291793          	slli	a5,s2,0x2
 6f2:	00000497          	auipc	s1,0x0
 6f6:	4a648493          	addi	s1,s1,1190 # b98 <putc_buf>
 6fa:	94be                	add	s1,s1,a5
 6fc:	3204a603          	lw	a2,800(s1)
 700:	85aa                	mv	a1,a0
 702:	854a                	mv	a0,s2
 704:	00000097          	auipc	ra,0x0
 708:	daa080e7          	jalr	-598(ra) # 4ae <write>
  putc_index[fd] = 0;
 70c:	3204a023          	sw	zero,800(s1)
}
 710:	60e2                	ld	ra,24(sp)
 712:	6442                	ld	s0,16(sp)
 714:	64a2                	ld	s1,8(sp)
 716:	6902                	ld	s2,0(sp)
 718:	6105                	addi	sp,sp,32
 71a:	8082                	ret

000000000000071c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 71c:	7119                	addi	sp,sp,-128
 71e:	fc86                	sd	ra,120(sp)
 720:	f8a2                	sd	s0,112(sp)
 722:	f4a6                	sd	s1,104(sp)
 724:	f0ca                	sd	s2,96(sp)
 726:	ecce                	sd	s3,88(sp)
 728:	e8d2                	sd	s4,80(sp)
 72a:	e4d6                	sd	s5,72(sp)
 72c:	e0da                	sd	s6,64(sp)
 72e:	fc5e                	sd	s7,56(sp)
 730:	f862                	sd	s8,48(sp)
 732:	f466                	sd	s9,40(sp)
 734:	f06a                	sd	s10,32(sp)
 736:	ec6e                	sd	s11,24(sp)
 738:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 73a:	0005c483          	lbu	s1,0(a1)
 73e:	18048d63          	beqz	s1,8d8 <vprintf+0x1bc>
 742:	8aaa                	mv	s5,a0
 744:	8b32                	mv	s6,a2
 746:	00158913          	addi	s2,a1,1
  state = 0;
 74a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 74c:	02500a13          	li	s4,37
      if(c == 'd'){
 750:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 754:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 758:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 75c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 760:	00000b97          	auipc	s7,0x0
 764:	3e8b8b93          	addi	s7,s7,1000 # b48 <digits>
 768:	a839                	j	786 <vprintf+0x6a>
        putc(fd, c);
 76a:	85a6                	mv	a1,s1
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	e36080e7          	jalr	-458(ra) # 5a4 <putc>
 776:	a019                	j	77c <vprintf+0x60>
    } else if(state == '%'){
 778:	01498f63          	beq	s3,s4,796 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 77c:	0905                	addi	s2,s2,1
 77e:	fff94483          	lbu	s1,-1(s2)
 782:	14048b63          	beqz	s1,8d8 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 786:	0004879b          	sext.w	a5,s1
    if(state == 0){
 78a:	fe0997e3          	bnez	s3,778 <vprintf+0x5c>
      if(c == '%'){
 78e:	fd479ee3          	bne	a5,s4,76a <vprintf+0x4e>
        state = '%';
 792:	89be                	mv	s3,a5
 794:	b7e5                	j	77c <vprintf+0x60>
      if(c == 'd'){
 796:	05878063          	beq	a5,s8,7d6 <vprintf+0xba>
      } else if(c == 'l') {
 79a:	05978c63          	beq	a5,s9,7f2 <vprintf+0xd6>
      } else if(c == 'x') {
 79e:	07a78863          	beq	a5,s10,80e <vprintf+0xf2>
      } else if(c == 'p') {
 7a2:	09b78463          	beq	a5,s11,82a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7a6:	07300713          	li	a4,115
 7aa:	0ce78563          	beq	a5,a4,874 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ae:	06300713          	li	a4,99
 7b2:	0ee78c63          	beq	a5,a4,8aa <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7b6:	11478663          	beq	a5,s4,8c2 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7ba:	85d2                	mv	a1,s4
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	de6080e7          	jalr	-538(ra) # 5a4 <putc>
        putc(fd, c);
 7c6:	85a6                	mv	a1,s1
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	dda080e7          	jalr	-550(ra) # 5a4 <putc>
      }
      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	b765                	j	77c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7d6:	008b0493          	addi	s1,s6,8
 7da:	4685                	li	a3,1
 7dc:	4629                	li	a2,10
 7de:	000b2583          	lw	a1,0(s6)
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	e46080e7          	jalr	-442(ra) # 62a <printint>
 7ec:	8b26                	mv	s6,s1
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b771                	j	77c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f2:	008b0493          	addi	s1,s6,8
 7f6:	4681                	li	a3,0
 7f8:	4629                	li	a2,10
 7fa:	000b2583          	lw	a1,0(s6)
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	e2a080e7          	jalr	-470(ra) # 62a <printint>
 808:	8b26                	mv	s6,s1
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bf85                	j	77c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 80e:	008b0493          	addi	s1,s6,8
 812:	4681                	li	a3,0
 814:	4641                	li	a2,16
 816:	000b2583          	lw	a1,0(s6)
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	e0e080e7          	jalr	-498(ra) # 62a <printint>
 824:	8b26                	mv	s6,s1
      state = 0;
 826:	4981                	li	s3,0
 828:	bf91                	j	77c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 82a:	008b0793          	addi	a5,s6,8
 82e:	f8f43423          	sd	a5,-120(s0)
 832:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 836:	03000593          	li	a1,48
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	d68080e7          	jalr	-664(ra) # 5a4 <putc>
  putc(fd, 'x');
 844:	85ea                	mv	a1,s10
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	d5c080e7          	jalr	-676(ra) # 5a4 <putc>
 850:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 852:	03c9d793          	srli	a5,s3,0x3c
 856:	97de                	add	a5,a5,s7
 858:	0007c583          	lbu	a1,0(a5)
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	d46080e7          	jalr	-698(ra) # 5a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 866:	0992                	slli	s3,s3,0x4
 868:	34fd                	addiw	s1,s1,-1
 86a:	f4e5                	bnez	s1,852 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 86c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 870:	4981                	li	s3,0
 872:	b729                	j	77c <vprintf+0x60>
        s = va_arg(ap, char*);
 874:	008b0993          	addi	s3,s6,8
 878:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 87c:	c085                	beqz	s1,89c <vprintf+0x180>
        while(*s != 0){
 87e:	0004c583          	lbu	a1,0(s1)
 882:	c9a1                	beqz	a1,8d2 <vprintf+0x1b6>
          putc(fd, *s);
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	d1e080e7          	jalr	-738(ra) # 5a4 <putc>
          s++;
 88e:	0485                	addi	s1,s1,1
        while(*s != 0){
 890:	0004c583          	lbu	a1,0(s1)
 894:	f9e5                	bnez	a1,884 <vprintf+0x168>
        s = va_arg(ap, char*);
 896:	8b4e                	mv	s6,s3
      state = 0;
 898:	4981                	li	s3,0
 89a:	b5cd                	j	77c <vprintf+0x60>
          s = "(null)";
 89c:	00000497          	auipc	s1,0x0
 8a0:	2c448493          	addi	s1,s1,708 # b60 <digits+0x18>
        while(*s != 0){
 8a4:	02800593          	li	a1,40
 8a8:	bff1                	j	884 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 8aa:	008b0493          	addi	s1,s6,8
 8ae:	000b4583          	lbu	a1,0(s6)
 8b2:	8556                	mv	a0,s5
 8b4:	00000097          	auipc	ra,0x0
 8b8:	cf0080e7          	jalr	-784(ra) # 5a4 <putc>
 8bc:	8b26                	mv	s6,s1
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	bd75                	j	77c <vprintf+0x60>
        putc(fd, c);
 8c2:	85d2                	mv	a1,s4
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	cde080e7          	jalr	-802(ra) # 5a4 <putc>
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	b575                	j	77c <vprintf+0x60>
        s = va_arg(ap, char*);
 8d2:	8b4e                	mv	s6,s3
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	b55d                	j	77c <vprintf+0x60>
    }
  }
}
 8d8:	70e6                	ld	ra,120(sp)
 8da:	7446                	ld	s0,112(sp)
 8dc:	74a6                	ld	s1,104(sp)
 8de:	7906                	ld	s2,96(sp)
 8e0:	69e6                	ld	s3,88(sp)
 8e2:	6a46                	ld	s4,80(sp)
 8e4:	6aa6                	ld	s5,72(sp)
 8e6:	6b06                	ld	s6,64(sp)
 8e8:	7be2                	ld	s7,56(sp)
 8ea:	7c42                	ld	s8,48(sp)
 8ec:	7ca2                	ld	s9,40(sp)
 8ee:	7d02                	ld	s10,32(sp)
 8f0:	6de2                	ld	s11,24(sp)
 8f2:	6109                	addi	sp,sp,128
 8f4:	8082                	ret

00000000000008f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f6:	715d                	addi	sp,sp,-80
 8f8:	ec06                	sd	ra,24(sp)
 8fa:	e822                	sd	s0,16(sp)
 8fc:	1000                	addi	s0,sp,32
 8fe:	e010                	sd	a2,0(s0)
 900:	e414                	sd	a3,8(s0)
 902:	e818                	sd	a4,16(s0)
 904:	ec1c                	sd	a5,24(s0)
 906:	03043023          	sd	a6,32(s0)
 90a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 912:	8622                	mv	a2,s0
 914:	00000097          	auipc	ra,0x0
 918:	e08080e7          	jalr	-504(ra) # 71c <vprintf>
}
 91c:	60e2                	ld	ra,24(sp)
 91e:	6442                	ld	s0,16(sp)
 920:	6161                	addi	sp,sp,80
 922:	8082                	ret

0000000000000924 <printf>:

void
printf(const char *fmt, ...)
{
 924:	711d                	addi	sp,sp,-96
 926:	ec06                	sd	ra,24(sp)
 928:	e822                	sd	s0,16(sp)
 92a:	1000                	addi	s0,sp,32
 92c:	e40c                	sd	a1,8(s0)
 92e:	e810                	sd	a2,16(s0)
 930:	ec14                	sd	a3,24(s0)
 932:	f018                	sd	a4,32(s0)
 934:	f41c                	sd	a5,40(s0)
 936:	03043823          	sd	a6,48(s0)
 93a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 93e:	00840613          	addi	a2,s0,8
 942:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 946:	85aa                	mv	a1,a0
 948:	4505                	li	a0,1
 94a:	00000097          	auipc	ra,0x0
 94e:	dd2080e7          	jalr	-558(ra) # 71c <vprintf>
}
 952:	60e2                	ld	ra,24(sp)
 954:	6442                	ld	s0,16(sp)
 956:	6125                	addi	sp,sp,96
 958:	8082                	ret

000000000000095a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 95a:	1141                	addi	sp,sp,-16
 95c:	e422                	sd	s0,8(sp)
 95e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 960:	ff050693          	addi	a3,a0,-16 # ff0 <putc_index+0x138>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 964:	00000797          	auipc	a5,0x0
 968:	22c78793          	addi	a5,a5,556 # b90 <_edata>
 96c:	639c                	ld	a5,0(a5)
 96e:	a805                	j	99e <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 970:	4618                	lw	a4,8(a2)
 972:	9db9                	addw	a1,a1,a4
 974:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 978:	6398                	ld	a4,0(a5)
 97a:	6318                	ld	a4,0(a4)
 97c:	fee53823          	sd	a4,-16(a0)
 980:	a091                	j	9c4 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 982:	ff852703          	lw	a4,-8(a0)
 986:	9e39                	addw	a2,a2,a4
 988:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 98a:	ff053703          	ld	a4,-16(a0)
 98e:	e398                	sd	a4,0(a5)
 990:	a099                	j	9d6 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 992:	6398                	ld	a4,0(a5)
 994:	00e7e463          	bltu	a5,a4,99c <free+0x42>
 998:	00e6ea63          	bltu	a3,a4,9ac <free+0x52>
{
 99c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 99e:	fed7fae3          	bleu	a3,a5,992 <free+0x38>
 9a2:	6398                	ld	a4,0(a5)
 9a4:	00e6e463          	bltu	a3,a4,9ac <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a8:	fee7eae3          	bltu	a5,a4,99c <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 9ac:	ff852583          	lw	a1,-8(a0)
 9b0:	6390                	ld	a2,0(a5)
 9b2:	02059713          	slli	a4,a1,0x20
 9b6:	9301                	srli	a4,a4,0x20
 9b8:	0712                	slli	a4,a4,0x4
 9ba:	9736                	add	a4,a4,a3
 9bc:	fae60ae3          	beq	a2,a4,970 <free+0x16>
    bp->s.ptr = p->s.ptr;
 9c0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9c4:	4790                	lw	a2,8(a5)
 9c6:	02061713          	slli	a4,a2,0x20
 9ca:	9301                	srli	a4,a4,0x20
 9cc:	0712                	slli	a4,a4,0x4
 9ce:	973e                	add	a4,a4,a5
 9d0:	fae689e3          	beq	a3,a4,982 <free+0x28>
  } else
    p->s.ptr = bp;
 9d4:	e394                	sd	a3,0(a5)
  freep = p;
 9d6:	00000717          	auipc	a4,0x0
 9da:	1af73d23          	sd	a5,442(a4) # b90 <_edata>
}
 9de:	6422                	ld	s0,8(sp)
 9e0:	0141                	addi	sp,sp,16
 9e2:	8082                	ret

00000000000009e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e4:	7139                	addi	sp,sp,-64
 9e6:	fc06                	sd	ra,56(sp)
 9e8:	f822                	sd	s0,48(sp)
 9ea:	f426                	sd	s1,40(sp)
 9ec:	f04a                	sd	s2,32(sp)
 9ee:	ec4e                	sd	s3,24(sp)
 9f0:	e852                	sd	s4,16(sp)
 9f2:	e456                	sd	s5,8(sp)
 9f4:	e05a                	sd	s6,0(sp)
 9f6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f8:	02051993          	slli	s3,a0,0x20
 9fc:	0209d993          	srli	s3,s3,0x20
 a00:	09bd                	addi	s3,s3,15
 a02:	0049d993          	srli	s3,s3,0x4
 a06:	2985                	addiw	s3,s3,1
 a08:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 a0c:	00000797          	auipc	a5,0x0
 a10:	18478793          	addi	a5,a5,388 # b90 <_edata>
 a14:	6388                	ld	a0,0(a5)
 a16:	c515                	beqz	a0,a42 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a18:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1a:	4798                	lw	a4,8(a5)
 a1c:	03277f63          	bleu	s2,a4,a5a <malloc+0x76>
 a20:	8a4e                	mv	s4,s3
 a22:	0009871b          	sext.w	a4,s3
 a26:	6685                	lui	a3,0x1
 a28:	00d77363          	bleu	a3,a4,a2e <malloc+0x4a>
 a2c:	6a05                	lui	s4,0x1
 a2e:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 a32:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a36:	00000497          	auipc	s1,0x0
 a3a:	15a48493          	addi	s1,s1,346 # b90 <_edata>
  if(p == (char*)-1)
 a3e:	5b7d                	li	s6,-1
 a40:	a885                	j	ab0 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a42:	00000797          	auipc	a5,0x0
 a46:	60678793          	addi	a5,a5,1542 # 1048 <base>
 a4a:	00000717          	auipc	a4,0x0
 a4e:	14f73323          	sd	a5,326(a4) # b90 <_edata>
 a52:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a54:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a58:	b7e1                	j	a20 <malloc+0x3c>
      if(p->s.size == nunits)
 a5a:	02e90b63          	beq	s2,a4,a90 <malloc+0xac>
        p->s.size -= nunits;
 a5e:	4137073b          	subw	a4,a4,s3
 a62:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a64:	1702                	slli	a4,a4,0x20
 a66:	9301                	srli	a4,a4,0x20
 a68:	0712                	slli	a4,a4,0x4
 a6a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a6c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a70:	00000717          	auipc	a4,0x0
 a74:	12a73023          	sd	a0,288(a4) # b90 <_edata>
      return (void*)(p + 1);
 a78:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a7c:	70e2                	ld	ra,56(sp)
 a7e:	7442                	ld	s0,48(sp)
 a80:	74a2                	ld	s1,40(sp)
 a82:	7902                	ld	s2,32(sp)
 a84:	69e2                	ld	s3,24(sp)
 a86:	6a42                	ld	s4,16(sp)
 a88:	6aa2                	ld	s5,8(sp)
 a8a:	6b02                	ld	s6,0(sp)
 a8c:	6121                	addi	sp,sp,64
 a8e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a90:	6398                	ld	a4,0(a5)
 a92:	e118                	sd	a4,0(a0)
 a94:	bff1                	j	a70 <malloc+0x8c>
  hp->s.size = nu;
 a96:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 a9a:	0541                	addi	a0,a0,16
 a9c:	00000097          	auipc	ra,0x0
 aa0:	ebe080e7          	jalr	-322(ra) # 95a <free>
  return freep;
 aa4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 aa6:	d979                	beqz	a0,a7c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aaa:	4798                	lw	a4,8(a5)
 aac:	fb2777e3          	bleu	s2,a4,a5a <malloc+0x76>
    if(p == freep)
 ab0:	6098                	ld	a4,0(s1)
 ab2:	853e                	mv	a0,a5
 ab4:	fef71ae3          	bne	a4,a5,aa8 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 ab8:	8552                	mv	a0,s4
 aba:	00000097          	auipc	ra,0x0
 abe:	a5c080e7          	jalr	-1444(ra) # 516 <sbrk>
  if(p == (char*)-1)
 ac2:	fd651ae3          	bne	a0,s6,a96 <malloc+0xb2>
        return 0;
 ac6:	4501                	li	a0,0
 ac8:	bf55                	j	a7c <malloc+0x98>
