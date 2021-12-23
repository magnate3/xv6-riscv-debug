
user/_rocky:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <freadint>:
#include "kernel/fcntl.h"
#include "user/user.h"

#define MAXLEN 20

int freadint(char * fname){
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
   e:	00000097          	auipc	ra,0x0
  12:	67e080e7          	jalr	1662(ra) # 68c <open>
  16:	892a                	mv	s2,a0
  if(read(fd, buf, MAXLEN) > 0){
  18:	4651                	li	a2,20
  1a:	fc840593          	addi	a1,s0,-56
  1e:	00000097          	auipc	ra,0x0
  22:	646080e7          	jalr	1606(ra) # 664 <read>
  26:	02a05963          	blez	a0,58 <freadint+0x58>
    res = atoi(buf);
  2a:	fc840513          	addi	a0,s0,-56
  2e:	00000097          	auipc	ra,0x0
  32:	47e080e7          	jalr	1150(ra) # 4ac <atoi>
  36:	84aa                	mv	s1,a0
  int res = -1;
  38:	020007b7          	lui	a5,0x2000
  }
  int j = 0;
  for(int i = 0; i < (1 << 25); i++)
  3c:	37fd                	addiw	a5,a5,-1
  3e:	fffd                	bnez	a5,3c <freadint+0x3c>
    j += i;
  close(fd);
  40:	854a                	mv	a0,s2
  42:	00000097          	auipc	ra,0x0
  46:	56e080e7          	jalr	1390(ra) # 5b0 <close>
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
  5a:	bff9                	j	38 <freadint+0x38>

000000000000005c <fwriteint>:

void fwriteint(char* fname, int i){
  5c:	1101                	addi	sp,sp,-32
  5e:	ec06                	sd	ra,24(sp)
  60:	e822                	sd	s0,16(sp)
  62:	e426                	sd	s1,8(sp)
  64:	e04a                	sd	s2,0(sp)
  66:	1000                	addi	s0,sp,32
  68:	892e                	mv	s2,a1
  int fd = open(fname, O_CREATE | O_RDWR);
  6a:	20200593          	li	a1,514
  6e:	00000097          	auipc	ra,0x0
  72:	61e080e7          	jalr	1566(ra) # 68c <open>
  76:	84aa                	mv	s1,a0
  fprintf(fd, "%d\n", i);
  78:	864a                	mv	a2,s2
  7a:	00001597          	auipc	a1,0x1
  7e:	c9e58593          	addi	a1,a1,-866 # d18 <malloc+0x176>
  82:	00001097          	auipc	ra,0x1
  86:	a32080e7          	jalr	-1486(ra) # ab4 <fprintf>
  8a:	020007b7          	lui	a5,0x2000
  int j = 0;
  for(int i = 0; i < (1 << 25); i++)
  8e:	37fd                	addiw	a5,a5,-1
  90:	fffd                	bnez	a5,8e <fwriteint+0x32>
    j += i;
  close(fd);
  92:	8526                	mv	a0,s1
  94:	00000097          	auipc	ra,0x0
  98:	51c080e7          	jalr	1308(ra) # 5b0 <close>
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	6442                	ld	s0,16(sp)
  a0:	64a2                	ld	s1,8(sp)
  a2:	6902                	ld	s2,0(sp)
  a4:	6105                	addi	sp,sp,32
  a6:	8082                	ret

00000000000000a8 <panic>:

void
panic(char *s)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e406                	sd	ra,8(sp)
  ac:	e022                	sd	s0,0(sp)
  ae:	0800                	addi	s0,sp,16
  fprintf(2, "%s\n", s);
  b0:	862a                	mv	a2,a0
  b2:	00001597          	auipc	a1,0x1
  b6:	bd658593          	addi	a1,a1,-1066 # c88 <malloc+0xe6>
  ba:	4509                	li	a0,2
  bc:	00001097          	auipc	ra,0x1
  c0:	9f8080e7          	jalr	-1544(ra) # ab4 <fprintf>
  exit(1);
  c4:	4505                	li	a0,1
  c6:	00000097          	auipc	ra,0x0
  ca:	586080e7          	jalr	1414(ra) # 64c <exit>

00000000000000ce <fork1>:
}

int
fork1(void)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  int pid;
  pid = fork();
  d6:	00000097          	auipc	ra,0x0
  da:	56e080e7          	jalr	1390(ra) # 644 <fork>
  if(pid == -1)
  de:	57fd                	li	a5,-1
  e0:	00f50663          	beq	a0,a5,ec <fork1+0x1e>
    panic("fork");
  return pid;
}
  e4:	60a2                	ld	ra,8(sp)
  e6:	6402                	ld	s0,0(sp)
  e8:	0141                	addi	sp,sp,16
  ea:	8082                	ret
    panic("fork");
  ec:	00001517          	auipc	a0,0x1
  f0:	ba450513          	addi	a0,a0,-1116 # c90 <malloc+0xee>
  f4:	00000097          	auipc	ra,0x0
  f8:	fb4080e7          	jalr	-76(ra) # a8 <panic>

00000000000000fc <get_weather>:

void get_weather(int mut){
  fc:	1101                	addi	sp,sp,-32
  fe:	ec06                	sd	ra,24(sp)
 100:	e822                	sd	s0,16(sp)
 102:	e426                	sd	s1,8(sp)
 104:	1000                	addi	s0,sp,32
 106:	84aa                	mv	s1,a0
  acquire_mutex(mut);
 108:	00000097          	auipc	ra,0x0
 10c:	5fc080e7          	jalr	1532(ra) # 704 <acquire_mutex>
  printf("Getting weather\n");
 110:	00001517          	auipc	a0,0x1
 114:	b8850513          	addi	a0,a0,-1144 # c98 <malloc+0xf6>
 118:	00001097          	auipc	ra,0x1
 11c:	9ca080e7          	jalr	-1590(ra) # ae2 <printf>
  int w = freadint("donnees_meteo");
 120:	00001517          	auipc	a0,0x1
 124:	b9050513          	addi	a0,a0,-1136 # cb0 <malloc+0x10e>
 128:	00000097          	auipc	ra,0x0
 12c:	ed8080e7          	jalr	-296(ra) # 0 <freadint>
  fwriteint("a_envoyer_a_la_terre", w);
 130:	85aa                	mv	a1,a0
 132:	00001517          	auipc	a0,0x1
 136:	b8e50513          	addi	a0,a0,-1138 # cc0 <malloc+0x11e>
 13a:	00000097          	auipc	ra,0x0
 13e:	f22080e7          	jalr	-222(ra) # 5c <fwriteint>
  release_mutex(mut);
 142:	8526                	mv	a0,s1
 144:	00000097          	auipc	ra,0x0
 148:	5c8080e7          	jalr	1480(ra) # 70c <release_mutex>
  printf("Exiting weather\n");
 14c:	00001517          	auipc	a0,0x1
 150:	b8c50513          	addi	a0,a0,-1140 # cd8 <malloc+0x136>
 154:	00001097          	auipc	ra,0x1
 158:	98e080e7          	jalr	-1650(ra) # ae2 <printf>
  sleep(2);
 15c:	4509                	li	a0,2
 15e:	00000097          	auipc	ra,0x0
 162:	57e080e7          	jalr	1406(ra) # 6dc <sleep>
}
 166:	60e2                	ld	ra,24(sp)
 168:	6442                	ld	s0,16(sp)
 16a:	64a2                	ld	s1,8(sp)
 16c:	6105                	addi	sp,sp,32
 16e:	8082                	ret

0000000000000170 <watchdog>:

int lasttime = 0;
#define THRESHOLD 20
#define NITER 100
void watchdog(int mut, int watchdog_fd){
 170:	715d                	addi	sp,sp,-80
 172:	e486                	sd	ra,72(sp)
 174:	e0a2                	sd	s0,64(sp)
 176:	fc26                	sd	s1,56(sp)
 178:	f84a                	sd	s2,48(sp)
 17a:	f44e                	sd	s3,40(sp)
 17c:	f052                	sd	s4,32(sp)
 17e:	ec56                	sd	s5,24(sp)
 180:	0880                	addi	s0,sp,80
 182:	84aa                	mv	s1,a0
 184:	8aae                	mv	s5,a1
  while(1){
    printf("Watchdog...\n");
 186:	00001a17          	auipc	s4,0x1
 18a:	b6aa0a13          	addi	s4,s4,-1174 # cf0 <malloc+0x14e>
    acquire_mutex(mut);
    char reset = 20;
 18e:	49d1                	li	s3,20
    int time_since_last_write = write(watchdog_fd, &reset, 1);
    printf("time_since_last_write = %d\n", time_since_last_write);
 190:	00001917          	auipc	s2,0x1
 194:	b7090913          	addi	s2,s2,-1168 # d00 <malloc+0x15e>
    printf("Watchdog...\n");
 198:	8552                	mv	a0,s4
 19a:	00001097          	auipc	ra,0x1
 19e:	948080e7          	jalr	-1720(ra) # ae2 <printf>
    acquire_mutex(mut);
 1a2:	8526                	mv	a0,s1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	560080e7          	jalr	1376(ra) # 704 <acquire_mutex>
    char reset = 20;
 1ac:	fb340fa3          	sb	s3,-65(s0)
    int time_since_last_write = write(watchdog_fd, &reset, 1);
 1b0:	4605                	li	a2,1
 1b2:	fbf40593          	addi	a1,s0,-65
 1b6:	8556                	mv	a0,s5
 1b8:	00000097          	auipc	ra,0x0
 1bc:	4b4080e7          	jalr	1204(ra) # 66c <write>
    printf("time_since_last_write = %d\n", time_since_last_write);
 1c0:	85aa                	mv	a1,a0
 1c2:	854a                	mv	a0,s2
 1c4:	00001097          	auipc	ra,0x1
 1c8:	91e080e7          	jalr	-1762(ra) # ae2 <printf>
    release_mutex(mut);
 1cc:	8526                	mv	a0,s1
 1ce:	00000097          	auipc	ra,0x0
 1d2:	53e080e7          	jalr	1342(ra) # 70c <release_mutex>
    sleep(15);
 1d6:	453d                	li	a0,15
 1d8:	00000097          	auipc	ra,0x0
 1dc:	504080e7          	jalr	1284(ra) # 6dc <sleep>
  while(1){
 1e0:	bf65                	j	198 <watchdog+0x28>

00000000000001e2 <transmit_to_earth>:
  }
}

void transmit_to_earth(){
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e406                	sd	ra,8(sp)
 1e6:	e022                	sd	s0,0(sp)
 1e8:	0800                	addi	s0,sp,16
  printf("Transmitting...\n");
 1ea:	00001517          	auipc	a0,0x1
 1ee:	b3650513          	addi	a0,a0,-1226 # d20 <malloc+0x17e>
 1f2:	00001097          	auipc	ra,0x1
 1f6:	8f0080e7          	jalr	-1808(ra) # ae2 <printf>
 1fa:	400007b7          	lui	a5,0x40000
  int j = 0;
  for(int i = 0; i < (1 << 30); i++)
 1fe:	37fd                	addiw	a5,a5,-1
 200:	fffd                	bnez	a5,1fe <transmit_to_earth+0x1c>
    j += i;
  printf("Done transmitting.\n");
 202:	00001517          	auipc	a0,0x1
 206:	b3650513          	addi	a0,a0,-1226 # d38 <malloc+0x196>
 20a:	00001097          	auipc	ra,0x1
 20e:	8d8080e7          	jalr	-1832(ra) # ae2 <printf>
  sleep(2);
 212:	4509                	li	a0,2
 214:	00000097          	auipc	ra,0x0
 218:	4c8080e7          	jalr	1224(ra) # 6dc <sleep>
}
 21c:	60a2                	ld	ra,8(sp)
 21e:	6402                	ld	s0,0(sp)
 220:	0141                	addi	sp,sp,16
 222:	8082                	ret

0000000000000224 <main>:

int main(){
 224:	7179                	addi	sp,sp,-48
 226:	f406                	sd	ra,40(sp)
 228:	f022                	sd	s0,32(sp)
 22a:	ec26                	sd	s1,24(sp)
 22c:	e84a                	sd	s2,16(sp)
 22e:	e44e                	sd	s3,8(sp)
 230:	e052                	sd	s4,0(sp)
 232:	1800                	addi	s0,sp,48
  int watchdog_fd;
  if((watchdog_fd = open("/watchdog", O_WRONLY)) < 0){
 234:	4585                	li	a1,1
 236:	00001517          	auipc	a0,0x1
 23a:	b1a50513          	addi	a0,a0,-1254 # d50 <malloc+0x1ae>
 23e:	00000097          	auipc	ra,0x0
 242:	44e080e7          	jalr	1102(ra) # 68c <open>
 246:	84aa                	mv	s1,a0
 248:	06054163          	bltz	a0,2aa <main+0x86>
    mknod("/watchdog", 2, 0);
    watchdog_fd = open("/watchdog", O_WRONLY);
  }
  fwriteint("donnees_meteo", 12);
 24c:	45b1                	li	a1,12
 24e:	00001517          	auipc	a0,0x1
 252:	a6250513          	addi	a0,a0,-1438 # cb0 <malloc+0x10e>
 256:	00000097          	auipc	ra,0x0
 25a:	e06080e7          	jalr	-506(ra) # 5c <fwriteint>
  int mut = create_mutex();
 25e:	00000097          	auipc	ra,0x0
 262:	49e080e7          	jalr	1182(ra) # 6fc <create_mutex>
 266:	892a                	mv	s2,a0
  int pid_get_weather;
  int pid_transmit_to_earth;
  int pid_watchdog;
  lasttime = uptime();
 268:	00000097          	auipc	ra,0x0
 26c:	47c080e7          	jalr	1148(ra) # 6e4 <uptime>
 270:	00001797          	auipc	a5,0x1
 274:	b0a7a823          	sw	a0,-1264(a5) # d80 <lasttime>
  if((pid_get_weather = fork1()) == 0){
 278:	00000097          	auipc	ra,0x0
 27c:	e56080e7          	jalr	-426(ra) # ce <fork1>
 280:	89aa                	mv	s3,a0
 282:	e929                	bnez	a0,2d4 <main+0xb0>
		sleep(10);
 284:	4529                	li	a0,10
 286:	00000097          	auipc	ra,0x0
 28a:	456080e7          	jalr	1110(ra) # 6dc <sleep>
 28e:	06400493          	li	s1,100
		for(int i = 0; i < NITER; i++)
	    get_weather(mut);
 292:	854a                	mv	a0,s2
 294:	00000097          	auipc	ra,0x0
 298:	e68080e7          	jalr	-408(ra) # fc <get_weather>
		for(int i = 0; i < NITER; i++)
 29c:	34fd                	addiw	s1,s1,-1
 29e:	f8f5                	bnez	s1,292 <main+0x6e>
    exit(0);
 2a0:	4501                	li	a0,0
 2a2:	00000097          	auipc	ra,0x0
 2a6:	3aa080e7          	jalr	938(ra) # 64c <exit>
    mknod("/watchdog", 2, 0);
 2aa:	4601                	li	a2,0
 2ac:	4589                	li	a1,2
 2ae:	00001517          	auipc	a0,0x1
 2b2:	aa250513          	addi	a0,a0,-1374 # d50 <malloc+0x1ae>
 2b6:	00000097          	auipc	ra,0x0
 2ba:	3de080e7          	jalr	990(ra) # 694 <mknod>
    watchdog_fd = open("/watchdog", O_WRONLY);
 2be:	4585                	li	a1,1
 2c0:	00001517          	auipc	a0,0x1
 2c4:	a9050513          	addi	a0,a0,-1392 # d50 <malloc+0x1ae>
 2c8:	00000097          	auipc	ra,0x0
 2cc:	3c4080e7          	jalr	964(ra) # 68c <open>
 2d0:	84aa                	mv	s1,a0
 2d2:	bfad                	j	24c <main+0x28>
  } else if((pid_transmit_to_earth = fork1()) == 0){
 2d4:	00000097          	auipc	ra,0x0
 2d8:	dfa080e7          	jalr	-518(ra) # ce <fork1>
 2dc:	8a2a                	mv	s4,a0
 2de:	e11d                	bnez	a0,304 <main+0xe0>
		sleep(10);
 2e0:	4529                	li	a0,10
 2e2:	00000097          	auipc	ra,0x0
 2e6:	3fa080e7          	jalr	1018(ra) # 6dc <sleep>
 2ea:	06400493          	li	s1,100
		for(int i = 0; i < NITER; i++)
	    transmit_to_earth();
 2ee:	00000097          	auipc	ra,0x0
 2f2:	ef4080e7          	jalr	-268(ra) # 1e2 <transmit_to_earth>
		for(int i = 0; i < NITER; i++)
 2f6:	34fd                	addiw	s1,s1,-1
 2f8:	f8fd                	bnez	s1,2ee <main+0xca>
    exit(0);
 2fa:	4501                	li	a0,0
 2fc:	00000097          	auipc	ra,0x0
 300:	350080e7          	jalr	848(ra) # 64c <exit>
  } else if((pid_watchdog = fork1()) == 0){
 304:	00000097          	auipc	ra,0x0
 308:	dca080e7          	jalr	-566(ra) # ce <fork1>
 30c:	ed01                	bnez	a0,324 <main+0x100>
		sleep(10);
 30e:	4529                	li	a0,10
 310:	00000097          	auipc	ra,0x0
 314:	3cc080e7          	jalr	972(ra) # 6dc <sleep>
    watchdog(mut, watchdog_fd);
 318:	85a6                	mv	a1,s1
 31a:	854a                	mv	a0,s2
 31c:	00000097          	auipc	ra,0x0
 320:	e54080e7          	jalr	-428(ra) # 170 <watchdog>
    exit(0);
  } else {
    nice(pid_watchdog, 0);
 324:	4581                	li	a1,0
 326:	00000097          	auipc	ra,0x0
 32a:	3ce080e7          	jalr	974(ra) # 6f4 <nice>
    nice(pid_transmit_to_earth, 5);
 32e:	4595                	li	a1,5
 330:	8552                	mv	a0,s4
 332:	00000097          	auipc	ra,0x0
 336:	3c2080e7          	jalr	962(ra) # 6f4 <nice>
    nice(pid_get_weather, 9);
 33a:	45a5                	li	a1,9
 33c:	854e                	mv	a0,s3
 33e:	00000097          	auipc	ra,0x0
 342:	3b6080e7          	jalr	950(ra) # 6f4 <nice>
    wait(0);
 346:	4501                	li	a0,0
 348:	00000097          	auipc	ra,0x0
 34c:	30c080e7          	jalr	780(ra) # 654 <wait>
    wait(0);
 350:	4501                	li	a0,0
 352:	00000097          	auipc	ra,0x0
 356:	302080e7          	jalr	770(ra) # 654 <wait>
    wait(0);
 35a:	4501                	li	a0,0
 35c:	00000097          	auipc	ra,0x0
 360:	2f8080e7          	jalr	760(ra) # 654 <wait>
    exit(0);
 364:	4501                	li	a0,0
 366:	00000097          	auipc	ra,0x0
 36a:	2e6080e7          	jalr	742(ra) # 64c <exit>

000000000000036e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 36e:	1141                	addi	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 374:	87aa                	mv	a5,a0
 376:	0585                	addi	a1,a1,1
 378:	0785                	addi	a5,a5,1
 37a:	fff5c703          	lbu	a4,-1(a1)
 37e:	fee78fa3          	sb	a4,-1(a5)
 382:	fb75                	bnez	a4,376 <strcpy+0x8>
    ;
  return os;
}
 384:	6422                	ld	s0,8(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret

000000000000038a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 390:	00054783          	lbu	a5,0(a0)
 394:	cf91                	beqz	a5,3b0 <strcmp+0x26>
 396:	0005c703          	lbu	a4,0(a1)
 39a:	00f71b63          	bne	a4,a5,3b0 <strcmp+0x26>
    p++, q++;
 39e:	0505                	addi	a0,a0,1
 3a0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3a2:	00054783          	lbu	a5,0(a0)
 3a6:	c789                	beqz	a5,3b0 <strcmp+0x26>
 3a8:	0005c703          	lbu	a4,0(a1)
 3ac:	fef709e3          	beq	a4,a5,39e <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 3b0:	0005c503          	lbu	a0,0(a1)
}
 3b4:	40a7853b          	subw	a0,a5,a0
 3b8:	6422                	ld	s0,8(sp)
 3ba:	0141                	addi	sp,sp,16
 3bc:	8082                	ret

00000000000003be <strlen>:

uint
strlen(const char *s)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3c4:	00054783          	lbu	a5,0(a0)
 3c8:	cf91                	beqz	a5,3e4 <strlen+0x26>
 3ca:	0505                	addi	a0,a0,1
 3cc:	87aa                	mv	a5,a0
 3ce:	4685                	li	a3,1
 3d0:	9e89                	subw	a3,a3,a0
 3d2:	00f6853b          	addw	a0,a3,a5
 3d6:	0785                	addi	a5,a5,1
 3d8:	fff7c703          	lbu	a4,-1(a5)
 3dc:	fb7d                	bnez	a4,3d2 <strlen+0x14>
    ;
  return n;
}
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	addi	sp,sp,16
 3e2:	8082                	ret
  for(n = 0; s[n]; n++)
 3e4:	4501                	li	a0,0
 3e6:	bfe5                	j	3de <strlen+0x20>

00000000000003e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3ee:	ce09                	beqz	a2,408 <memset+0x20>
 3f0:	87aa                	mv	a5,a0
 3f2:	fff6071b          	addiw	a4,a2,-1
 3f6:	1702                	slli	a4,a4,0x20
 3f8:	9301                	srli	a4,a4,0x20
 3fa:	0705                	addi	a4,a4,1
 3fc:	972a                	add	a4,a4,a0
    cdst[i] = c;
 3fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 402:	0785                	addi	a5,a5,1
 404:	fee79de3          	bne	a5,a4,3fe <memset+0x16>
  }
  return dst;
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret

000000000000040e <strchr>:

char*
strchr(const char *s, char c)
{
 40e:	1141                	addi	sp,sp,-16
 410:	e422                	sd	s0,8(sp)
 412:	0800                	addi	s0,sp,16
  for(; *s; s++)
 414:	00054783          	lbu	a5,0(a0)
 418:	cf91                	beqz	a5,434 <strchr+0x26>
    if(*s == c)
 41a:	00f58a63          	beq	a1,a5,42e <strchr+0x20>
  for(; *s; s++)
 41e:	0505                	addi	a0,a0,1
 420:	00054783          	lbu	a5,0(a0)
 424:	c781                	beqz	a5,42c <strchr+0x1e>
    if(*s == c)
 426:	feb79ce3          	bne	a5,a1,41e <strchr+0x10>
 42a:	a011                	j	42e <strchr+0x20>
      return (char*)s;
  return 0;
 42c:	4501                	li	a0,0
}
 42e:	6422                	ld	s0,8(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret
  return 0;
 434:	4501                	li	a0,0
 436:	bfe5                	j	42e <strchr+0x20>

0000000000000438 <gets>:

char*
gets(char *buf, int max)
{
 438:	711d                	addi	sp,sp,-96
 43a:	ec86                	sd	ra,88(sp)
 43c:	e8a2                	sd	s0,80(sp)
 43e:	e4a6                	sd	s1,72(sp)
 440:	e0ca                	sd	s2,64(sp)
 442:	fc4e                	sd	s3,56(sp)
 444:	f852                	sd	s4,48(sp)
 446:	f456                	sd	s5,40(sp)
 448:	f05a                	sd	s6,32(sp)
 44a:	ec5e                	sd	s7,24(sp)
 44c:	1080                	addi	s0,sp,96
 44e:	8baa                	mv	s7,a0
 450:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 452:	892a                	mv	s2,a0
 454:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 456:	4aa9                	li	s5,10
 458:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 45a:	0019849b          	addiw	s1,s3,1
 45e:	0344d863          	ble	s4,s1,48e <gets+0x56>
    cc = read(0, &c, 1);
 462:	4605                	li	a2,1
 464:	faf40593          	addi	a1,s0,-81
 468:	4501                	li	a0,0
 46a:	00000097          	auipc	ra,0x0
 46e:	1fa080e7          	jalr	506(ra) # 664 <read>
    if(cc < 1)
 472:	00a05e63          	blez	a0,48e <gets+0x56>
    buf[i++] = c;
 476:	faf44783          	lbu	a5,-81(s0)
 47a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 47e:	01578763          	beq	a5,s5,48c <gets+0x54>
 482:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 484:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 486:	fd679ae3          	bne	a5,s6,45a <gets+0x22>
 48a:	a011                	j	48e <gets+0x56>
  for(i=0; i+1 < max; ){
 48c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 48e:	99de                	add	s3,s3,s7
 490:	00098023          	sb	zero,0(s3)
  return buf;
}
 494:	855e                	mv	a0,s7
 496:	60e6                	ld	ra,88(sp)
 498:	6446                	ld	s0,80(sp)
 49a:	64a6                	ld	s1,72(sp)
 49c:	6906                	ld	s2,64(sp)
 49e:	79e2                	ld	s3,56(sp)
 4a0:	7a42                	ld	s4,48(sp)
 4a2:	7aa2                	ld	s5,40(sp)
 4a4:	7b02                	ld	s6,32(sp)
 4a6:	6be2                	ld	s7,24(sp)
 4a8:	6125                	addi	sp,sp,96
 4aa:	8082                	ret

00000000000004ac <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4ac:	1141                	addi	sp,sp,-16
 4ae:	e422                	sd	s0,8(sp)
 4b0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4b2:	00054683          	lbu	a3,0(a0)
 4b6:	fd06879b          	addiw	a5,a3,-48
 4ba:	0ff7f793          	andi	a5,a5,255
 4be:	4725                	li	a4,9
 4c0:	02f76963          	bltu	a4,a5,4f2 <atoi+0x46>
 4c4:	862a                	mv	a2,a0
  n = 0;
 4c6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4c8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4ca:	0605                	addi	a2,a2,1
 4cc:	0025179b          	slliw	a5,a0,0x2
 4d0:	9fa9                	addw	a5,a5,a0
 4d2:	0017979b          	slliw	a5,a5,0x1
 4d6:	9fb5                	addw	a5,a5,a3
 4d8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4dc:	00064683          	lbu	a3,0(a2)
 4e0:	fd06871b          	addiw	a4,a3,-48
 4e4:	0ff77713          	andi	a4,a4,255
 4e8:	fee5f1e3          	bleu	a4,a1,4ca <atoi+0x1e>
  return n;
}
 4ec:	6422                	ld	s0,8(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret
  n = 0;
 4f2:	4501                	li	a0,0
 4f4:	bfe5                	j	4ec <atoi+0x40>

00000000000004f6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e422                	sd	s0,8(sp)
 4fa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4fc:	02b57663          	bleu	a1,a0,528 <memmove+0x32>
    while(n-- > 0)
 500:	02c05163          	blez	a2,522 <memmove+0x2c>
 504:	fff6079b          	addiw	a5,a2,-1
 508:	1782                	slli	a5,a5,0x20
 50a:	9381                	srli	a5,a5,0x20
 50c:	0785                	addi	a5,a5,1
 50e:	97aa                	add	a5,a5,a0
  dst = vdst;
 510:	872a                	mv	a4,a0
      *dst++ = *src++;
 512:	0585                	addi	a1,a1,1
 514:	0705                	addi	a4,a4,1
 516:	fff5c683          	lbu	a3,-1(a1)
 51a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 51e:	fee79ae3          	bne	a5,a4,512 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 522:	6422                	ld	s0,8(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret
    dst += n;
 528:	00c50733          	add	a4,a0,a2
    src += n;
 52c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 52e:	fec05ae3          	blez	a2,522 <memmove+0x2c>
 532:	fff6079b          	addiw	a5,a2,-1
 536:	1782                	slli	a5,a5,0x20
 538:	9381                	srli	a5,a5,0x20
 53a:	fff7c793          	not	a5,a5
 53e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 540:	15fd                	addi	a1,a1,-1
 542:	177d                	addi	a4,a4,-1
 544:	0005c683          	lbu	a3,0(a1)
 548:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 54c:	fef71ae3          	bne	a4,a5,540 <memmove+0x4a>
 550:	bfc9                	j	522 <memmove+0x2c>

0000000000000552 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 552:	1141                	addi	sp,sp,-16
 554:	e422                	sd	s0,8(sp)
 556:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 558:	ce15                	beqz	a2,594 <memcmp+0x42>
 55a:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 55e:	00054783          	lbu	a5,0(a0)
 562:	0005c703          	lbu	a4,0(a1)
 566:	02e79063          	bne	a5,a4,586 <memcmp+0x34>
 56a:	1682                	slli	a3,a3,0x20
 56c:	9281                	srli	a3,a3,0x20
 56e:	0685                	addi	a3,a3,1
 570:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 572:	0505                	addi	a0,a0,1
    p2++;
 574:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 576:	00d50d63          	beq	a0,a3,590 <memcmp+0x3e>
    if (*p1 != *p2) {
 57a:	00054783          	lbu	a5,0(a0)
 57e:	0005c703          	lbu	a4,0(a1)
 582:	fee788e3          	beq	a5,a4,572 <memcmp+0x20>
      return *p1 - *p2;
 586:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 58a:	6422                	ld	s0,8(sp)
 58c:	0141                	addi	sp,sp,16
 58e:	8082                	ret
  return 0;
 590:	4501                	li	a0,0
 592:	bfe5                	j	58a <memcmp+0x38>
 594:	4501                	li	a0,0
 596:	bfd5                	j	58a <memcmp+0x38>

0000000000000598 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 598:	1141                	addi	sp,sp,-16
 59a:	e406                	sd	ra,8(sp)
 59c:	e022                	sd	s0,0(sp)
 59e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5a0:	00000097          	auipc	ra,0x0
 5a4:	f56080e7          	jalr	-170(ra) # 4f6 <memmove>
}
 5a8:	60a2                	ld	ra,8(sp)
 5aa:	6402                	ld	s0,0(sp)
 5ac:	0141                	addi	sp,sp,16
 5ae:	8082                	ret

00000000000005b0 <close>:

int close(int fd){
 5b0:	1101                	addi	sp,sp,-32
 5b2:	ec06                	sd	ra,24(sp)
 5b4:	e822                	sd	s0,16(sp)
 5b6:	e426                	sd	s1,8(sp)
 5b8:	1000                	addi	s0,sp,32
 5ba:	84aa                	mv	s1,a0
  fflush(fd);
 5bc:	00000097          	auipc	ra,0x0
 5c0:	2da080e7          	jalr	730(ra) # 896 <fflush>
  char* buf = get_putc_buf(fd);
 5c4:	8526                	mv	a0,s1
 5c6:	00000097          	auipc	ra,0x0
 5ca:	14e080e7          	jalr	334(ra) # 714 <get_putc_buf>
  if(buf){
 5ce:	cd11                	beqz	a0,5ea <close+0x3a>
    free(buf);
 5d0:	00000097          	auipc	ra,0x0
 5d4:	548080e7          	jalr	1352(ra) # b18 <free>
    putc_buf[fd] = 0;
 5d8:	00349713          	slli	a4,s1,0x3
 5dc:	00000797          	auipc	a5,0x0
 5e0:	7b478793          	addi	a5,a5,1972 # d90 <putc_buf>
 5e4:	97ba                	add	a5,a5,a4
 5e6:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 5ea:	8526                	mv	a0,s1
 5ec:	00000097          	auipc	ra,0x0
 5f0:	088080e7          	jalr	136(ra) # 674 <sclose>
}
 5f4:	60e2                	ld	ra,24(sp)
 5f6:	6442                	ld	s0,16(sp)
 5f8:	64a2                	ld	s1,8(sp)
 5fa:	6105                	addi	sp,sp,32
 5fc:	8082                	ret

00000000000005fe <stat>:
{
 5fe:	1101                	addi	sp,sp,-32
 600:	ec06                	sd	ra,24(sp)
 602:	e822                	sd	s0,16(sp)
 604:	e426                	sd	s1,8(sp)
 606:	e04a                	sd	s2,0(sp)
 608:	1000                	addi	s0,sp,32
 60a:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 60c:	4581                	li	a1,0
 60e:	00000097          	auipc	ra,0x0
 612:	07e080e7          	jalr	126(ra) # 68c <open>
  if(fd < 0)
 616:	02054563          	bltz	a0,640 <stat+0x42>
 61a:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 61c:	85ca                	mv	a1,s2
 61e:	00000097          	auipc	ra,0x0
 622:	086080e7          	jalr	134(ra) # 6a4 <fstat>
 626:	892a                	mv	s2,a0
  close(fd);
 628:	8526                	mv	a0,s1
 62a:	00000097          	auipc	ra,0x0
 62e:	f86080e7          	jalr	-122(ra) # 5b0 <close>
}
 632:	854a                	mv	a0,s2
 634:	60e2                	ld	ra,24(sp)
 636:	6442                	ld	s0,16(sp)
 638:	64a2                	ld	s1,8(sp)
 63a:	6902                	ld	s2,0(sp)
 63c:	6105                	addi	sp,sp,32
 63e:	8082                	ret
    return -1;
 640:	597d                	li	s2,-1
 642:	bfc5                	j	632 <stat+0x34>

0000000000000644 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 644:	4885                	li	a7,1
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <exit>:
.global exit
exit:
 li a7, SYS_exit
 64c:	4889                	li	a7,2
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <wait>:
.global wait
wait:
 li a7, SYS_wait
 654:	488d                	li	a7,3
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 65c:	4891                	li	a7,4
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <read>:
.global read
read:
 li a7, SYS_read
 664:	4895                	li	a7,5
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <write>:
.global write
write:
 li a7, SYS_write
 66c:	48c1                	li	a7,16
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 674:	48d5                	li	a7,21
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <kill>:
.global kill
kill:
 li a7, SYS_kill
 67c:	4899                	li	a7,6
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <exec>:
.global exec
exec:
 li a7, SYS_exec
 684:	489d                	li	a7,7
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <open>:
.global open
open:
 li a7, SYS_open
 68c:	48bd                	li	a7,15
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 694:	48c5                	li	a7,17
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 69c:	48c9                	li	a7,18
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6a4:	48a1                	li	a7,8
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <link>:
.global link
link:
 li a7, SYS_link
 6ac:	48cd                	li	a7,19
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6b4:	48d1                	li	a7,20
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6bc:	48a5                	li	a7,9
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6c4:	48a9                	li	a7,10
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6cc:	48ad                	li	a7,11
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6d4:	48b1                	li	a7,12
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6dc:	48b5                	li	a7,13
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6e4:	48b9                	li	a7,14
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 6ec:	48d9                	li	a7,22
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <nice>:
.global nice
nice:
 li a7, SYS_nice
 6f4:	48dd                	li	a7,23
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 6fc:	48e1                	li	a7,24
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 704:	48e5                	li	a7,25
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 70c:	48e9                	li	a7,26
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 714:	1101                	addi	sp,sp,-32
 716:	ec06                	sd	ra,24(sp)
 718:	e822                	sd	s0,16(sp)
 71a:	e426                	sd	s1,8(sp)
 71c:	1000                	addi	s0,sp,32
 71e:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 720:	00351693          	slli	a3,a0,0x3
 724:	00000797          	auipc	a5,0x0
 728:	66c78793          	addi	a5,a5,1644 # d90 <putc_buf>
 72c:	97b6                	add	a5,a5,a3
 72e:	6388                	ld	a0,0(a5)
  if(buf) {
 730:	c511                	beqz	a0,73c <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 732:	60e2                	ld	ra,24(sp)
 734:	6442                	ld	s0,16(sp)
 736:	64a2                	ld	s1,8(sp)
 738:	6105                	addi	sp,sp,32
 73a:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 73c:	6505                	lui	a0,0x1
 73e:	00000097          	auipc	ra,0x0
 742:	464080e7          	jalr	1124(ra) # ba2 <malloc>
  putc_buf[fd] = buf;
 746:	00000797          	auipc	a5,0x0
 74a:	64a78793          	addi	a5,a5,1610 # d90 <putc_buf>
 74e:	00349713          	slli	a4,s1,0x3
 752:	973e                	add	a4,a4,a5
 754:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 756:	00249713          	slli	a4,s1,0x2
 75a:	973e                	add	a4,a4,a5
 75c:	32072023          	sw	zero,800(a4)
  return buf;
 760:	bfc9                	j	732 <get_putc_buf+0x1e>

0000000000000762 <putc>:

static void
putc(int fd, char c)
{
 762:	1101                	addi	sp,sp,-32
 764:	ec06                	sd	ra,24(sp)
 766:	e822                	sd	s0,16(sp)
 768:	e426                	sd	s1,8(sp)
 76a:	e04a                	sd	s2,0(sp)
 76c:	1000                	addi	s0,sp,32
 76e:	84aa                	mv	s1,a0
 770:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 772:	00000097          	auipc	ra,0x0
 776:	fa2080e7          	jalr	-94(ra) # 714 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 77a:	00249793          	slli	a5,s1,0x2
 77e:	00000717          	auipc	a4,0x0
 782:	61270713          	addi	a4,a4,1554 # d90 <putc_buf>
 786:	973e                	add	a4,a4,a5
 788:	32072783          	lw	a5,800(a4)
 78c:	0017869b          	addiw	a3,a5,1
 790:	32d72023          	sw	a3,800(a4)
 794:	97aa                	add	a5,a5,a0
 796:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 79a:	47a9                	li	a5,10
 79c:	02f90463          	beq	s2,a5,7c4 <putc+0x62>
 7a0:	00249713          	slli	a4,s1,0x2
 7a4:	00000797          	auipc	a5,0x0
 7a8:	5ec78793          	addi	a5,a5,1516 # d90 <putc_buf>
 7ac:	97ba                	add	a5,a5,a4
 7ae:	3207a703          	lw	a4,800(a5)
 7b2:	6785                	lui	a5,0x1
 7b4:	00f70863          	beq	a4,a5,7c4 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 7b8:	60e2                	ld	ra,24(sp)
 7ba:	6442                	ld	s0,16(sp)
 7bc:	64a2                	ld	s1,8(sp)
 7be:	6902                	ld	s2,0(sp)
 7c0:	6105                	addi	sp,sp,32
 7c2:	8082                	ret
    write(fd, buf, putc_index[fd]);
 7c4:	00249793          	slli	a5,s1,0x2
 7c8:	00000917          	auipc	s2,0x0
 7cc:	5c890913          	addi	s2,s2,1480 # d90 <putc_buf>
 7d0:	993e                	add	s2,s2,a5
 7d2:	32092603          	lw	a2,800(s2)
 7d6:	85aa                	mv	a1,a0
 7d8:	8526                	mv	a0,s1
 7da:	00000097          	auipc	ra,0x0
 7de:	e92080e7          	jalr	-366(ra) # 66c <write>
    putc_index[fd] = 0;
 7e2:	32092023          	sw	zero,800(s2)
}
 7e6:	bfc9                	j	7b8 <putc+0x56>

00000000000007e8 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7e8:	7139                	addi	sp,sp,-64
 7ea:	fc06                	sd	ra,56(sp)
 7ec:	f822                	sd	s0,48(sp)
 7ee:	f426                	sd	s1,40(sp)
 7f0:	f04a                	sd	s2,32(sp)
 7f2:	ec4e                	sd	s3,24(sp)
 7f4:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7f6:	c299                	beqz	a3,7fc <printint+0x14>
 7f8:	0005cd63          	bltz	a1,812 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7fc:	2581                	sext.w	a1,a1
  neg = 0;
 7fe:	4301                	li	t1,0
 800:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 804:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 806:	2601                	sext.w	a2,a2
 808:	00000897          	auipc	a7,0x0
 80c:	55888893          	addi	a7,a7,1368 # d60 <digits>
 810:	a801                	j	820 <printint+0x38>
    x = -xx;
 812:	40b005bb          	negw	a1,a1
 816:	2581                	sext.w	a1,a1
    neg = 1;
 818:	4305                	li	t1,1
    x = -xx;
 81a:	b7dd                	j	800 <printint+0x18>
  }while((x /= base) != 0);
 81c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 81e:	8836                	mv	a6,a3
 820:	0018069b          	addiw	a3,a6,1
 824:	02c5f7bb          	remuw	a5,a1,a2
 828:	1782                	slli	a5,a5,0x20
 82a:	9381                	srli	a5,a5,0x20
 82c:	97c6                	add	a5,a5,a7
 82e:	0007c783          	lbu	a5,0(a5) # 1000 <putc_buf+0x270>
 832:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 836:	0705                	addi	a4,a4,1
 838:	02c5d7bb          	divuw	a5,a1,a2
 83c:	fec5f0e3          	bleu	a2,a1,81c <printint+0x34>
  if(neg)
 840:	00030b63          	beqz	t1,856 <printint+0x6e>
    buf[i++] = '-';
 844:	fd040793          	addi	a5,s0,-48
 848:	96be                	add	a3,a3,a5
 84a:	02d00793          	li	a5,45
 84e:	fef68823          	sb	a5,-16(a3)
 852:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 856:	02d05963          	blez	a3,888 <printint+0xa0>
 85a:	89aa                	mv	s3,a0
 85c:	fc040793          	addi	a5,s0,-64
 860:	00d784b3          	add	s1,a5,a3
 864:	fff78913          	addi	s2,a5,-1
 868:	9936                	add	s2,s2,a3
 86a:	36fd                	addiw	a3,a3,-1
 86c:	1682                	slli	a3,a3,0x20
 86e:	9281                	srli	a3,a3,0x20
 870:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 874:	fff4c583          	lbu	a1,-1(s1)
 878:	854e                	mv	a0,s3
 87a:	00000097          	auipc	ra,0x0
 87e:	ee8080e7          	jalr	-280(ra) # 762 <putc>
  while(--i >= 0)
 882:	14fd                	addi	s1,s1,-1
 884:	ff2498e3          	bne	s1,s2,874 <printint+0x8c>
}
 888:	70e2                	ld	ra,56(sp)
 88a:	7442                	ld	s0,48(sp)
 88c:	74a2                	ld	s1,40(sp)
 88e:	7902                	ld	s2,32(sp)
 890:	69e2                	ld	s3,24(sp)
 892:	6121                	addi	sp,sp,64
 894:	8082                	ret

0000000000000896 <fflush>:
void fflush(int fd){
 896:	1101                	addi	sp,sp,-32
 898:	ec06                	sd	ra,24(sp)
 89a:	e822                	sd	s0,16(sp)
 89c:	e426                	sd	s1,8(sp)
 89e:	e04a                	sd	s2,0(sp)
 8a0:	1000                	addi	s0,sp,32
 8a2:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 8a4:	00000097          	auipc	ra,0x0
 8a8:	e70080e7          	jalr	-400(ra) # 714 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 8ac:	00291793          	slli	a5,s2,0x2
 8b0:	00000497          	auipc	s1,0x0
 8b4:	4e048493          	addi	s1,s1,1248 # d90 <putc_buf>
 8b8:	94be                	add	s1,s1,a5
 8ba:	3204a603          	lw	a2,800(s1)
 8be:	85aa                	mv	a1,a0
 8c0:	854a                	mv	a0,s2
 8c2:	00000097          	auipc	ra,0x0
 8c6:	daa080e7          	jalr	-598(ra) # 66c <write>
  putc_index[fd] = 0;
 8ca:	3204a023          	sw	zero,800(s1)
}
 8ce:	60e2                	ld	ra,24(sp)
 8d0:	6442                	ld	s0,16(sp)
 8d2:	64a2                	ld	s1,8(sp)
 8d4:	6902                	ld	s2,0(sp)
 8d6:	6105                	addi	sp,sp,32
 8d8:	8082                	ret

00000000000008da <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8da:	7119                	addi	sp,sp,-128
 8dc:	fc86                	sd	ra,120(sp)
 8de:	f8a2                	sd	s0,112(sp)
 8e0:	f4a6                	sd	s1,104(sp)
 8e2:	f0ca                	sd	s2,96(sp)
 8e4:	ecce                	sd	s3,88(sp)
 8e6:	e8d2                	sd	s4,80(sp)
 8e8:	e4d6                	sd	s5,72(sp)
 8ea:	e0da                	sd	s6,64(sp)
 8ec:	fc5e                	sd	s7,56(sp)
 8ee:	f862                	sd	s8,48(sp)
 8f0:	f466                	sd	s9,40(sp)
 8f2:	f06a                	sd	s10,32(sp)
 8f4:	ec6e                	sd	s11,24(sp)
 8f6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8f8:	0005c483          	lbu	s1,0(a1)
 8fc:	18048d63          	beqz	s1,a96 <vprintf+0x1bc>
 900:	8aaa                	mv	s5,a0
 902:	8b32                	mv	s6,a2
 904:	00158913          	addi	s2,a1,1
  state = 0;
 908:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 90a:	02500a13          	li	s4,37
      if(c == 'd'){
 90e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 912:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 916:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 91a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 91e:	00000b97          	auipc	s7,0x0
 922:	442b8b93          	addi	s7,s7,1090 # d60 <digits>
 926:	a839                	j	944 <vprintf+0x6a>
        putc(fd, c);
 928:	85a6                	mv	a1,s1
 92a:	8556                	mv	a0,s5
 92c:	00000097          	auipc	ra,0x0
 930:	e36080e7          	jalr	-458(ra) # 762 <putc>
 934:	a019                	j	93a <vprintf+0x60>
    } else if(state == '%'){
 936:	01498f63          	beq	s3,s4,954 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 93a:	0905                	addi	s2,s2,1
 93c:	fff94483          	lbu	s1,-1(s2)
 940:	14048b63          	beqz	s1,a96 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 944:	0004879b          	sext.w	a5,s1
    if(state == 0){
 948:	fe0997e3          	bnez	s3,936 <vprintf+0x5c>
      if(c == '%'){
 94c:	fd479ee3          	bne	a5,s4,928 <vprintf+0x4e>
        state = '%';
 950:	89be                	mv	s3,a5
 952:	b7e5                	j	93a <vprintf+0x60>
      if(c == 'd'){
 954:	05878063          	beq	a5,s8,994 <vprintf+0xba>
      } else if(c == 'l') {
 958:	05978c63          	beq	a5,s9,9b0 <vprintf+0xd6>
      } else if(c == 'x') {
 95c:	07a78863          	beq	a5,s10,9cc <vprintf+0xf2>
      } else if(c == 'p') {
 960:	09b78463          	beq	a5,s11,9e8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 964:	07300713          	li	a4,115
 968:	0ce78563          	beq	a5,a4,a32 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 96c:	06300713          	li	a4,99
 970:	0ee78c63          	beq	a5,a4,a68 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 974:	11478663          	beq	a5,s4,a80 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 978:	85d2                	mv	a1,s4
 97a:	8556                	mv	a0,s5
 97c:	00000097          	auipc	ra,0x0
 980:	de6080e7          	jalr	-538(ra) # 762 <putc>
        putc(fd, c);
 984:	85a6                	mv	a1,s1
 986:	8556                	mv	a0,s5
 988:	00000097          	auipc	ra,0x0
 98c:	dda080e7          	jalr	-550(ra) # 762 <putc>
      }
      state = 0;
 990:	4981                	li	s3,0
 992:	b765                	j	93a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 994:	008b0493          	addi	s1,s6,8
 998:	4685                	li	a3,1
 99a:	4629                	li	a2,10
 99c:	000b2583          	lw	a1,0(s6)
 9a0:	8556                	mv	a0,s5
 9a2:	00000097          	auipc	ra,0x0
 9a6:	e46080e7          	jalr	-442(ra) # 7e8 <printint>
 9aa:	8b26                	mv	s6,s1
      state = 0;
 9ac:	4981                	li	s3,0
 9ae:	b771                	j	93a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9b0:	008b0493          	addi	s1,s6,8
 9b4:	4681                	li	a3,0
 9b6:	4629                	li	a2,10
 9b8:	000b2583          	lw	a1,0(s6)
 9bc:	8556                	mv	a0,s5
 9be:	00000097          	auipc	ra,0x0
 9c2:	e2a080e7          	jalr	-470(ra) # 7e8 <printint>
 9c6:	8b26                	mv	s6,s1
      state = 0;
 9c8:	4981                	li	s3,0
 9ca:	bf85                	j	93a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9cc:	008b0493          	addi	s1,s6,8
 9d0:	4681                	li	a3,0
 9d2:	4641                	li	a2,16
 9d4:	000b2583          	lw	a1,0(s6)
 9d8:	8556                	mv	a0,s5
 9da:	00000097          	auipc	ra,0x0
 9de:	e0e080e7          	jalr	-498(ra) # 7e8 <printint>
 9e2:	8b26                	mv	s6,s1
      state = 0;
 9e4:	4981                	li	s3,0
 9e6:	bf91                	j	93a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 9e8:	008b0793          	addi	a5,s6,8
 9ec:	f8f43423          	sd	a5,-120(s0)
 9f0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 9f4:	03000593          	li	a1,48
 9f8:	8556                	mv	a0,s5
 9fa:	00000097          	auipc	ra,0x0
 9fe:	d68080e7          	jalr	-664(ra) # 762 <putc>
  putc(fd, 'x');
 a02:	85ea                	mv	a1,s10
 a04:	8556                	mv	a0,s5
 a06:	00000097          	auipc	ra,0x0
 a0a:	d5c080e7          	jalr	-676(ra) # 762 <putc>
 a0e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a10:	03c9d793          	srli	a5,s3,0x3c
 a14:	97de                	add	a5,a5,s7
 a16:	0007c583          	lbu	a1,0(a5)
 a1a:	8556                	mv	a0,s5
 a1c:	00000097          	auipc	ra,0x0
 a20:	d46080e7          	jalr	-698(ra) # 762 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a24:	0992                	slli	s3,s3,0x4
 a26:	34fd                	addiw	s1,s1,-1
 a28:	f4e5                	bnez	s1,a10 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 a2a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a2e:	4981                	li	s3,0
 a30:	b729                	j	93a <vprintf+0x60>
        s = va_arg(ap, char*);
 a32:	008b0993          	addi	s3,s6,8
 a36:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 a3a:	c085                	beqz	s1,a5a <vprintf+0x180>
        while(*s != 0){
 a3c:	0004c583          	lbu	a1,0(s1)
 a40:	c9a1                	beqz	a1,a90 <vprintf+0x1b6>
          putc(fd, *s);
 a42:	8556                	mv	a0,s5
 a44:	00000097          	auipc	ra,0x0
 a48:	d1e080e7          	jalr	-738(ra) # 762 <putc>
          s++;
 a4c:	0485                	addi	s1,s1,1
        while(*s != 0){
 a4e:	0004c583          	lbu	a1,0(s1)
 a52:	f9e5                	bnez	a1,a42 <vprintf+0x168>
        s = va_arg(ap, char*);
 a54:	8b4e                	mv	s6,s3
      state = 0;
 a56:	4981                	li	s3,0
 a58:	b5cd                	j	93a <vprintf+0x60>
          s = "(null)";
 a5a:	00000497          	auipc	s1,0x0
 a5e:	31e48493          	addi	s1,s1,798 # d78 <digits+0x18>
        while(*s != 0){
 a62:	02800593          	li	a1,40
 a66:	bff1                	j	a42 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 a68:	008b0493          	addi	s1,s6,8
 a6c:	000b4583          	lbu	a1,0(s6)
 a70:	8556                	mv	a0,s5
 a72:	00000097          	auipc	ra,0x0
 a76:	cf0080e7          	jalr	-784(ra) # 762 <putc>
 a7a:	8b26                	mv	s6,s1
      state = 0;
 a7c:	4981                	li	s3,0
 a7e:	bd75                	j	93a <vprintf+0x60>
        putc(fd, c);
 a80:	85d2                	mv	a1,s4
 a82:	8556                	mv	a0,s5
 a84:	00000097          	auipc	ra,0x0
 a88:	cde080e7          	jalr	-802(ra) # 762 <putc>
      state = 0;
 a8c:	4981                	li	s3,0
 a8e:	b575                	j	93a <vprintf+0x60>
        s = va_arg(ap, char*);
 a90:	8b4e                	mv	s6,s3
      state = 0;
 a92:	4981                	li	s3,0
 a94:	b55d                	j	93a <vprintf+0x60>
    }
  }
}
 a96:	70e6                	ld	ra,120(sp)
 a98:	7446                	ld	s0,112(sp)
 a9a:	74a6                	ld	s1,104(sp)
 a9c:	7906                	ld	s2,96(sp)
 a9e:	69e6                	ld	s3,88(sp)
 aa0:	6a46                	ld	s4,80(sp)
 aa2:	6aa6                	ld	s5,72(sp)
 aa4:	6b06                	ld	s6,64(sp)
 aa6:	7be2                	ld	s7,56(sp)
 aa8:	7c42                	ld	s8,48(sp)
 aaa:	7ca2                	ld	s9,40(sp)
 aac:	7d02                	ld	s10,32(sp)
 aae:	6de2                	ld	s11,24(sp)
 ab0:	6109                	addi	sp,sp,128
 ab2:	8082                	ret

0000000000000ab4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ab4:	715d                	addi	sp,sp,-80
 ab6:	ec06                	sd	ra,24(sp)
 ab8:	e822                	sd	s0,16(sp)
 aba:	1000                	addi	s0,sp,32
 abc:	e010                	sd	a2,0(s0)
 abe:	e414                	sd	a3,8(s0)
 ac0:	e818                	sd	a4,16(s0)
 ac2:	ec1c                	sd	a5,24(s0)
 ac4:	03043023          	sd	a6,32(s0)
 ac8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 acc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ad0:	8622                	mv	a2,s0
 ad2:	00000097          	auipc	ra,0x0
 ad6:	e08080e7          	jalr	-504(ra) # 8da <vprintf>
}
 ada:	60e2                	ld	ra,24(sp)
 adc:	6442                	ld	s0,16(sp)
 ade:	6161                	addi	sp,sp,80
 ae0:	8082                	ret

0000000000000ae2 <printf>:

void
printf(const char *fmt, ...)
{
 ae2:	711d                	addi	sp,sp,-96
 ae4:	ec06                	sd	ra,24(sp)
 ae6:	e822                	sd	s0,16(sp)
 ae8:	1000                	addi	s0,sp,32
 aea:	e40c                	sd	a1,8(s0)
 aec:	e810                	sd	a2,16(s0)
 aee:	ec14                	sd	a3,24(s0)
 af0:	f018                	sd	a4,32(s0)
 af2:	f41c                	sd	a5,40(s0)
 af4:	03043823          	sd	a6,48(s0)
 af8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 afc:	00840613          	addi	a2,s0,8
 b00:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b04:	85aa                	mv	a1,a0
 b06:	4505                	li	a0,1
 b08:	00000097          	auipc	ra,0x0
 b0c:	dd2080e7          	jalr	-558(ra) # 8da <vprintf>
}
 b10:	60e2                	ld	ra,24(sp)
 b12:	6442                	ld	s0,16(sp)
 b14:	6125                	addi	sp,sp,96
 b16:	8082                	ret

0000000000000b18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b18:	1141                	addi	sp,sp,-16
 b1a:	e422                	sd	s0,8(sp)
 b1c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b1e:	ff050693          	addi	a3,a0,-16 # ff0 <putc_buf+0x260>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b22:	00000797          	auipc	a5,0x0
 b26:	26678793          	addi	a5,a5,614 # d88 <freep>
 b2a:	639c                	ld	a5,0(a5)
 b2c:	a805                	j	b5c <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b2e:	4618                	lw	a4,8(a2)
 b30:	9db9                	addw	a1,a1,a4
 b32:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b36:	6398                	ld	a4,0(a5)
 b38:	6318                	ld	a4,0(a4)
 b3a:	fee53823          	sd	a4,-16(a0)
 b3e:	a091                	j	b82 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b40:	ff852703          	lw	a4,-8(a0)
 b44:	9e39                	addw	a2,a2,a4
 b46:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 b48:	ff053703          	ld	a4,-16(a0)
 b4c:	e398                	sd	a4,0(a5)
 b4e:	a099                	j	b94 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b50:	6398                	ld	a4,0(a5)
 b52:	00e7e463          	bltu	a5,a4,b5a <free+0x42>
 b56:	00e6ea63          	bltu	a3,a4,b6a <free+0x52>
{
 b5a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b5c:	fed7fae3          	bleu	a3,a5,b50 <free+0x38>
 b60:	6398                	ld	a4,0(a5)
 b62:	00e6e463          	bltu	a3,a4,b6a <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b66:	fee7eae3          	bltu	a5,a4,b5a <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 b6a:	ff852583          	lw	a1,-8(a0)
 b6e:	6390                	ld	a2,0(a5)
 b70:	02059713          	slli	a4,a1,0x20
 b74:	9301                	srli	a4,a4,0x20
 b76:	0712                	slli	a4,a4,0x4
 b78:	9736                	add	a4,a4,a3
 b7a:	fae60ae3          	beq	a2,a4,b2e <free+0x16>
    bp->s.ptr = p->s.ptr;
 b7e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b82:	4790                	lw	a2,8(a5)
 b84:	02061713          	slli	a4,a2,0x20
 b88:	9301                	srli	a4,a4,0x20
 b8a:	0712                	slli	a4,a4,0x4
 b8c:	973e                	add	a4,a4,a5
 b8e:	fae689e3          	beq	a3,a4,b40 <free+0x28>
  } else
    p->s.ptr = bp;
 b92:	e394                	sd	a3,0(a5)
  freep = p;
 b94:	00000717          	auipc	a4,0x0
 b98:	1ef73a23          	sd	a5,500(a4) # d88 <freep>
}
 b9c:	6422                	ld	s0,8(sp)
 b9e:	0141                	addi	sp,sp,16
 ba0:	8082                	ret

0000000000000ba2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ba2:	7139                	addi	sp,sp,-64
 ba4:	fc06                	sd	ra,56(sp)
 ba6:	f822                	sd	s0,48(sp)
 ba8:	f426                	sd	s1,40(sp)
 baa:	f04a                	sd	s2,32(sp)
 bac:	ec4e                	sd	s3,24(sp)
 bae:	e852                	sd	s4,16(sp)
 bb0:	e456                	sd	s5,8(sp)
 bb2:	e05a                	sd	s6,0(sp)
 bb4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bb6:	02051993          	slli	s3,a0,0x20
 bba:	0209d993          	srli	s3,s3,0x20
 bbe:	09bd                	addi	s3,s3,15
 bc0:	0049d993          	srli	s3,s3,0x4
 bc4:	2985                	addiw	s3,s3,1
 bc6:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 bca:	00000797          	auipc	a5,0x0
 bce:	1be78793          	addi	a5,a5,446 # d88 <freep>
 bd2:	6388                	ld	a0,0(a5)
 bd4:	c515                	beqz	a0,c00 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bd8:	4798                	lw	a4,8(a5)
 bda:	03277f63          	bleu	s2,a4,c18 <malloc+0x76>
 bde:	8a4e                	mv	s4,s3
 be0:	0009871b          	sext.w	a4,s3
 be4:	6685                	lui	a3,0x1
 be6:	00d77363          	bleu	a3,a4,bec <malloc+0x4a>
 bea:	6a05                	lui	s4,0x1
 bec:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 bf0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bf4:	00000497          	auipc	s1,0x0
 bf8:	19448493          	addi	s1,s1,404 # d88 <freep>
  if(p == (char*)-1)
 bfc:	5b7d                	li	s6,-1
 bfe:	a885                	j	c6e <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 c00:	00000797          	auipc	a5,0x0
 c04:	64078793          	addi	a5,a5,1600 # 1240 <base>
 c08:	00000717          	auipc	a4,0x0
 c0c:	18f73023          	sd	a5,384(a4) # d88 <freep>
 c10:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c12:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c16:	b7e1                	j	bde <malloc+0x3c>
      if(p->s.size == nunits)
 c18:	02e90b63          	beq	s2,a4,c4e <malloc+0xac>
        p->s.size -= nunits;
 c1c:	4137073b          	subw	a4,a4,s3
 c20:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c22:	1702                	slli	a4,a4,0x20
 c24:	9301                	srli	a4,a4,0x20
 c26:	0712                	slli	a4,a4,0x4
 c28:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c2a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c2e:	00000717          	auipc	a4,0x0
 c32:	14a73d23          	sd	a0,346(a4) # d88 <freep>
      return (void*)(p + 1);
 c36:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c3a:	70e2                	ld	ra,56(sp)
 c3c:	7442                	ld	s0,48(sp)
 c3e:	74a2                	ld	s1,40(sp)
 c40:	7902                	ld	s2,32(sp)
 c42:	69e2                	ld	s3,24(sp)
 c44:	6a42                	ld	s4,16(sp)
 c46:	6aa2                	ld	s5,8(sp)
 c48:	6b02                	ld	s6,0(sp)
 c4a:	6121                	addi	sp,sp,64
 c4c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c4e:	6398                	ld	a4,0(a5)
 c50:	e118                	sd	a4,0(a0)
 c52:	bff1                	j	c2e <malloc+0x8c>
  hp->s.size = nu;
 c54:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 c58:	0541                	addi	a0,a0,16
 c5a:	00000097          	auipc	ra,0x0
 c5e:	ebe080e7          	jalr	-322(ra) # b18 <free>
  return freep;
 c62:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 c64:	d979                	beqz	a0,c3a <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c66:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c68:	4798                	lw	a4,8(a5)
 c6a:	fb2777e3          	bleu	s2,a4,c18 <malloc+0x76>
    if(p == freep)
 c6e:	6098                	ld	a4,0(s1)
 c70:	853e                	mv	a0,a5
 c72:	fef71ae3          	bne	a4,a5,c66 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 c76:	8552                	mv	a0,s4
 c78:	00000097          	auipc	ra,0x0
 c7c:	a5c080e7          	jalr	-1444(ra) # 6d4 <sbrk>
  if(p == (char*)-1)
 c80:	fd651ae3          	bne	a0,s6,c54 <malloc+0xb2>
        return 0;
 c84:	4501                	li	a0,0
 c86:	bf55                	j	c3a <malloc+0x98>
