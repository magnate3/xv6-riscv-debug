
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  fprintf(2, "$ ");
      10:	00001597          	auipc	a1,0x1
      14:	4c058593          	addi	a1,a1,1216 # 14d0 <malloc+0x11c>
      18:	4509                	li	a0,2
      1a:	00001097          	auipc	ra,0x1
      1e:	2ac080e7          	jalr	684(ra) # 12c6 <fprintf>
  fflush(2);
      22:	4509                	li	a0,2
      24:	00001097          	auipc	ra,0x1
      28:	084080e7          	jalr	132(ra) # 10a8 <fflush>
  memset(buf, 0, nbuf);
      2c:	864a                	mv	a2,s2
      2e:	4581                	li	a1,0
      30:	8526                	mv	a0,s1
      32:	00001097          	auipc	ra,0x1
      36:	bc8080e7          	jalr	-1080(ra) # bfa <memset>
  gets(buf, nbuf);
      3a:	85ca                	mv	a1,s2
      3c:	8526                	mv	a0,s1
      3e:	00001097          	auipc	ra,0x1
      42:	c0c080e7          	jalr	-1012(ra) # c4a <gets>
  if(buf[0] == 0) // EOF
      46:	0004c503          	lbu	a0,0(s1)
      4a:	00153513          	seqz	a0,a0
      4e:	40a0053b          	negw	a0,a0
    return -1;
  return 0;
}
      52:	2501                	sext.w	a0,a0
      54:	60e2                	ld	ra,24(sp)
      56:	6442                	ld	s0,16(sp)
      58:	64a2                	ld	s1,8(sp)
      5a:	6902                	ld	s2,0(sp)
      5c:	6105                	addi	sp,sp,32
      5e:	8082                	ret

0000000000000060 <panic>:
  exit(0);
}

void
panic(char *s)
{
      60:	1141                	addi	sp,sp,-16
      62:	e406                	sd	ra,8(sp)
      64:	e022                	sd	s0,0(sp)
      66:	0800                	addi	s0,sp,16
  fprintf(2, "%s\n", s);
      68:	862a                	mv	a2,a0
      6a:	00001597          	auipc	a1,0x1
      6e:	46e58593          	addi	a1,a1,1134 # 14d8 <malloc+0x124>
      72:	4509                	li	a0,2
      74:	00001097          	auipc	ra,0x1
      78:	252080e7          	jalr	594(ra) # 12c6 <fprintf>
  exit(1);
      7c:	4505                	li	a0,1
      7e:	00001097          	auipc	ra,0x1
      82:	de0080e7          	jalr	-544(ra) # e5e <exit>

0000000000000086 <fork1>:
}

int
fork1(void)
{
      86:	1141                	addi	sp,sp,-16
      88:	e406                	sd	ra,8(sp)
      8a:	e022                	sd	s0,0(sp)
      8c:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      8e:	00001097          	auipc	ra,0x1
      92:	dc8080e7          	jalr	-568(ra) # e56 <fork>
  if(pid == -1)
      96:	57fd                	li	a5,-1
      98:	00f50663          	beq	a0,a5,a4 <fork1+0x1e>
    panic("fork");
  return pid;
}
      9c:	60a2                	ld	ra,8(sp)
      9e:	6402                	ld	s0,0(sp)
      a0:	0141                	addi	sp,sp,16
      a2:	8082                	ret
    panic("fork");
      a4:	00001517          	auipc	a0,0x1
      a8:	43c50513          	addi	a0,a0,1084 # 14e0 <malloc+0x12c>
      ac:	00000097          	auipc	ra,0x0
      b0:	fb4080e7          	jalr	-76(ra) # 60 <panic>

00000000000000b4 <runcmd>:
{
      b4:	7179                	addi	sp,sp,-48
      b6:	f406                	sd	ra,40(sp)
      b8:	f022                	sd	s0,32(sp)
      ba:	ec26                	sd	s1,24(sp)
      bc:	1800                	addi	s0,sp,48
  if(cmd == 0)
      be:	c10d                	beqz	a0,e0 <runcmd+0x2c>
      c0:	84aa                	mv	s1,a0
  switch(cmd->type){
      c2:	4118                	lw	a4,0(a0)
      c4:	4795                	li	a5,5
      c6:	02e7e263          	bltu	a5,a4,ea <runcmd+0x36>
      ca:	00056783          	lwu	a5,0(a0)
      ce:	078a                	slli	a5,a5,0x2
      d0:	00001717          	auipc	a4,0x1
      d4:	3d070713          	addi	a4,a4,976 # 14a0 <malloc+0xec>
      d8:	97ba                	add	a5,a5,a4
      da:	439c                	lw	a5,0(a5)
      dc:	97ba                	add	a5,a5,a4
      de:	8782                	jr	a5
    exit(1);
      e0:	4505                	li	a0,1
      e2:	00001097          	auipc	ra,0x1
      e6:	d7c080e7          	jalr	-644(ra) # e5e <exit>
    panic("runcmd");
      ea:	00001517          	auipc	a0,0x1
      ee:	3fe50513          	addi	a0,a0,1022 # 14e8 <malloc+0x134>
      f2:	00000097          	auipc	ra,0x0
      f6:	f6e080e7          	jalr	-146(ra) # 60 <panic>
    if(ecmd->argv[0] == 0)
      fa:	6508                	ld	a0,8(a0)
      fc:	c515                	beqz	a0,128 <runcmd+0x74>
    exec(ecmd->argv[0], ecmd->argv);
      fe:	00848593          	addi	a1,s1,8
     102:	00001097          	auipc	ra,0x1
     106:	d94080e7          	jalr	-620(ra) # e96 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     10a:	6490                	ld	a2,8(s1)
     10c:	00001597          	auipc	a1,0x1
     110:	3e458593          	addi	a1,a1,996 # 14f0 <malloc+0x13c>
     114:	4509                	li	a0,2
     116:	00001097          	auipc	ra,0x1
     11a:	1b0080e7          	jalr	432(ra) # 12c6 <fprintf>
  exit(0);
     11e:	4501                	li	a0,0
     120:	00001097          	auipc	ra,0x1
     124:	d3e080e7          	jalr	-706(ra) # e5e <exit>
      exit(1);
     128:	4505                	li	a0,1
     12a:	00001097          	auipc	ra,0x1
     12e:	d34080e7          	jalr	-716(ra) # e5e <exit>
    close(rcmd->fd);
     132:	5148                	lw	a0,36(a0)
     134:	00001097          	auipc	ra,0x1
     138:	c8e080e7          	jalr	-882(ra) # dc2 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     13c:	508c                	lw	a1,32(s1)
     13e:	6888                	ld	a0,16(s1)
     140:	00001097          	auipc	ra,0x1
     144:	d5e080e7          	jalr	-674(ra) # e9e <open>
     148:	00054763          	bltz	a0,156 <runcmd+0xa2>
    runcmd(rcmd->cmd);
     14c:	6488                	ld	a0,8(s1)
     14e:	00000097          	auipc	ra,0x0
     152:	f66080e7          	jalr	-154(ra) # b4 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     156:	6890                	ld	a2,16(s1)
     158:	00001597          	auipc	a1,0x1
     15c:	3a858593          	addi	a1,a1,936 # 1500 <malloc+0x14c>
     160:	4509                	li	a0,2
     162:	00001097          	auipc	ra,0x1
     166:	164080e7          	jalr	356(ra) # 12c6 <fprintf>
      exit(1);
     16a:	4505                	li	a0,1
     16c:	00001097          	auipc	ra,0x1
     170:	cf2080e7          	jalr	-782(ra) # e5e <exit>
    if(fork1() == 0)
     174:	00000097          	auipc	ra,0x0
     178:	f12080e7          	jalr	-238(ra) # 86 <fork1>
     17c:	c919                	beqz	a0,192 <runcmd+0xde>
    wait(0);
     17e:	4501                	li	a0,0
     180:	00001097          	auipc	ra,0x1
     184:	ce6080e7          	jalr	-794(ra) # e66 <wait>
    runcmd(lcmd->right);
     188:	6888                	ld	a0,16(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f2a080e7          	jalr	-214(ra) # b4 <runcmd>
      runcmd(lcmd->left);
     192:	6488                	ld	a0,8(s1)
     194:	00000097          	auipc	ra,0x0
     198:	f20080e7          	jalr	-224(ra) # b4 <runcmd>
    if(pipe(p) < 0)
     19c:	fd840513          	addi	a0,s0,-40
     1a0:	00001097          	auipc	ra,0x1
     1a4:	cce080e7          	jalr	-818(ra) # e6e <pipe>
     1a8:	04054363          	bltz	a0,1ee <runcmd+0x13a>
    if(fork1() == 0){
     1ac:	00000097          	auipc	ra,0x0
     1b0:	eda080e7          	jalr	-294(ra) # 86 <fork1>
     1b4:	c529                	beqz	a0,1fe <runcmd+0x14a>
    if(fork1() == 0){
     1b6:	00000097          	auipc	ra,0x0
     1ba:	ed0080e7          	jalr	-304(ra) # 86 <fork1>
     1be:	cd25                	beqz	a0,236 <runcmd+0x182>
    close(p[0]);
     1c0:	fd842503          	lw	a0,-40(s0)
     1c4:	00001097          	auipc	ra,0x1
     1c8:	bfe080e7          	jalr	-1026(ra) # dc2 <close>
    close(p[1]);
     1cc:	fdc42503          	lw	a0,-36(s0)
     1d0:	00001097          	auipc	ra,0x1
     1d4:	bf2080e7          	jalr	-1038(ra) # dc2 <close>
    wait(0);
     1d8:	4501                	li	a0,0
     1da:	00001097          	auipc	ra,0x1
     1de:	c8c080e7          	jalr	-884(ra) # e66 <wait>
    wait(0);
     1e2:	4501                	li	a0,0
     1e4:	00001097          	auipc	ra,0x1
     1e8:	c82080e7          	jalr	-894(ra) # e66 <wait>
    break;
     1ec:	bf0d                	j	11e <runcmd+0x6a>
      panic("pipe");
     1ee:	00001517          	auipc	a0,0x1
     1f2:	32250513          	addi	a0,a0,802 # 1510 <malloc+0x15c>
     1f6:	00000097          	auipc	ra,0x0
     1fa:	e6a080e7          	jalr	-406(ra) # 60 <panic>
      close(1);
     1fe:	4505                	li	a0,1
     200:	00001097          	auipc	ra,0x1
     204:	bc2080e7          	jalr	-1086(ra) # dc2 <close>
      dup(p[1]);
     208:	fdc42503          	lw	a0,-36(s0)
     20c:	00001097          	auipc	ra,0x1
     210:	cca080e7          	jalr	-822(ra) # ed6 <dup>
      close(p[0]);
     214:	fd842503          	lw	a0,-40(s0)
     218:	00001097          	auipc	ra,0x1
     21c:	baa080e7          	jalr	-1110(ra) # dc2 <close>
      close(p[1]);
     220:	fdc42503          	lw	a0,-36(s0)
     224:	00001097          	auipc	ra,0x1
     228:	b9e080e7          	jalr	-1122(ra) # dc2 <close>
      runcmd(pcmd->left);
     22c:	6488                	ld	a0,8(s1)
     22e:	00000097          	auipc	ra,0x0
     232:	e86080e7          	jalr	-378(ra) # b4 <runcmd>
      close(0);
     236:	00001097          	auipc	ra,0x1
     23a:	b8c080e7          	jalr	-1140(ra) # dc2 <close>
      dup(p[0]);
     23e:	fd842503          	lw	a0,-40(s0)
     242:	00001097          	auipc	ra,0x1
     246:	c94080e7          	jalr	-876(ra) # ed6 <dup>
      close(p[0]);
     24a:	fd842503          	lw	a0,-40(s0)
     24e:	00001097          	auipc	ra,0x1
     252:	b74080e7          	jalr	-1164(ra) # dc2 <close>
      close(p[1]);
     256:	fdc42503          	lw	a0,-36(s0)
     25a:	00001097          	auipc	ra,0x1
     25e:	b68080e7          	jalr	-1176(ra) # dc2 <close>
      runcmd(pcmd->right);
     262:	6888                	ld	a0,16(s1)
     264:	00000097          	auipc	ra,0x0
     268:	e50080e7          	jalr	-432(ra) # b4 <runcmd>
    if(fork1() == 0)
     26c:	00000097          	auipc	ra,0x0
     270:	e1a080e7          	jalr	-486(ra) # 86 <fork1>
     274:	ea0515e3          	bnez	a0,11e <runcmd+0x6a>
      runcmd(bcmd->cmd);
     278:	6488                	ld	a0,8(s1)
     27a:	00000097          	auipc	ra,0x0
     27e:	e3a080e7          	jalr	-454(ra) # b4 <runcmd>

0000000000000282 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     282:	1101                	addi	sp,sp,-32
     284:	ec06                	sd	ra,24(sp)
     286:	e822                	sd	s0,16(sp)
     288:	e426                	sd	s1,8(sp)
     28a:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     28c:	0a800513          	li	a0,168
     290:	00001097          	auipc	ra,0x1
     294:	124080e7          	jalr	292(ra) # 13b4 <malloc>
     298:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     29a:	0a800613          	li	a2,168
     29e:	4581                	li	a1,0
     2a0:	00001097          	auipc	ra,0x1
     2a4:	95a080e7          	jalr	-1702(ra) # bfa <memset>
  cmd->type = EXEC;
     2a8:	4785                	li	a5,1
     2aa:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2ac:	8526                	mv	a0,s1
     2ae:	60e2                	ld	ra,24(sp)
     2b0:	6442                	ld	s0,16(sp)
     2b2:	64a2                	ld	s1,8(sp)
     2b4:	6105                	addi	sp,sp,32
     2b6:	8082                	ret

00000000000002b8 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2b8:	7139                	addi	sp,sp,-64
     2ba:	fc06                	sd	ra,56(sp)
     2bc:	f822                	sd	s0,48(sp)
     2be:	f426                	sd	s1,40(sp)
     2c0:	f04a                	sd	s2,32(sp)
     2c2:	ec4e                	sd	s3,24(sp)
     2c4:	e852                	sd	s4,16(sp)
     2c6:	e456                	sd	s5,8(sp)
     2c8:	e05a                	sd	s6,0(sp)
     2ca:	0080                	addi	s0,sp,64
     2cc:	8b2a                	mv	s6,a0
     2ce:	8aae                	mv	s5,a1
     2d0:	8a32                	mv	s4,a2
     2d2:	89b6                	mv	s3,a3
     2d4:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2d6:	02800513          	li	a0,40
     2da:	00001097          	auipc	ra,0x1
     2de:	0da080e7          	jalr	218(ra) # 13b4 <malloc>
     2e2:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2e4:	02800613          	li	a2,40
     2e8:	4581                	li	a1,0
     2ea:	00001097          	auipc	ra,0x1
     2ee:	910080e7          	jalr	-1776(ra) # bfa <memset>
  cmd->type = REDIR;
     2f2:	4789                	li	a5,2
     2f4:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2f6:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     2fa:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     2fe:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     302:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     306:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     30a:	8526                	mv	a0,s1
     30c:	70e2                	ld	ra,56(sp)
     30e:	7442                	ld	s0,48(sp)
     310:	74a2                	ld	s1,40(sp)
     312:	7902                	ld	s2,32(sp)
     314:	69e2                	ld	s3,24(sp)
     316:	6a42                	ld	s4,16(sp)
     318:	6aa2                	ld	s5,8(sp)
     31a:	6b02                	ld	s6,0(sp)
     31c:	6121                	addi	sp,sp,64
     31e:	8082                	ret

0000000000000320 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     320:	7179                	addi	sp,sp,-48
     322:	f406                	sd	ra,40(sp)
     324:	f022                	sd	s0,32(sp)
     326:	ec26                	sd	s1,24(sp)
     328:	e84a                	sd	s2,16(sp)
     32a:	e44e                	sd	s3,8(sp)
     32c:	1800                	addi	s0,sp,48
     32e:	89aa                	mv	s3,a0
     330:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     332:	4561                	li	a0,24
     334:	00001097          	auipc	ra,0x1
     338:	080080e7          	jalr	128(ra) # 13b4 <malloc>
     33c:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     33e:	4661                	li	a2,24
     340:	4581                	li	a1,0
     342:	00001097          	auipc	ra,0x1
     346:	8b8080e7          	jalr	-1864(ra) # bfa <memset>
  cmd->type = PIPE;
     34a:	478d                	li	a5,3
     34c:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     34e:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     352:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     356:	8526                	mv	a0,s1
     358:	70a2                	ld	ra,40(sp)
     35a:	7402                	ld	s0,32(sp)
     35c:	64e2                	ld	s1,24(sp)
     35e:	6942                	ld	s2,16(sp)
     360:	69a2                	ld	s3,8(sp)
     362:	6145                	addi	sp,sp,48
     364:	8082                	ret

0000000000000366 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     366:	7179                	addi	sp,sp,-48
     368:	f406                	sd	ra,40(sp)
     36a:	f022                	sd	s0,32(sp)
     36c:	ec26                	sd	s1,24(sp)
     36e:	e84a                	sd	s2,16(sp)
     370:	e44e                	sd	s3,8(sp)
     372:	1800                	addi	s0,sp,48
     374:	89aa                	mv	s3,a0
     376:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     378:	4561                	li	a0,24
     37a:	00001097          	auipc	ra,0x1
     37e:	03a080e7          	jalr	58(ra) # 13b4 <malloc>
     382:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     384:	4661                	li	a2,24
     386:	4581                	li	a1,0
     388:	00001097          	auipc	ra,0x1
     38c:	872080e7          	jalr	-1934(ra) # bfa <memset>
  cmd->type = LIST;
     390:	4791                	li	a5,4
     392:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     394:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     398:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     39c:	8526                	mv	a0,s1
     39e:	70a2                	ld	ra,40(sp)
     3a0:	7402                	ld	s0,32(sp)
     3a2:	64e2                	ld	s1,24(sp)
     3a4:	6942                	ld	s2,16(sp)
     3a6:	69a2                	ld	s3,8(sp)
     3a8:	6145                	addi	sp,sp,48
     3aa:	8082                	ret

00000000000003ac <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3ac:	1101                	addi	sp,sp,-32
     3ae:	ec06                	sd	ra,24(sp)
     3b0:	e822                	sd	s0,16(sp)
     3b2:	e426                	sd	s1,8(sp)
     3b4:	e04a                	sd	s2,0(sp)
     3b6:	1000                	addi	s0,sp,32
     3b8:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3ba:	4541                	li	a0,16
     3bc:	00001097          	auipc	ra,0x1
     3c0:	ff8080e7          	jalr	-8(ra) # 13b4 <malloc>
     3c4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3c6:	4641                	li	a2,16
     3c8:	4581                	li	a1,0
     3ca:	00001097          	auipc	ra,0x1
     3ce:	830080e7          	jalr	-2000(ra) # bfa <memset>
  cmd->type = BACK;
     3d2:	4795                	li	a5,5
     3d4:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3d6:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3da:	8526                	mv	a0,s1
     3dc:	60e2                	ld	ra,24(sp)
     3de:	6442                	ld	s0,16(sp)
     3e0:	64a2                	ld	s1,8(sp)
     3e2:	6902                	ld	s2,0(sp)
     3e4:	6105                	addi	sp,sp,32
     3e6:	8082                	ret

00000000000003e8 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3e8:	7139                	addi	sp,sp,-64
     3ea:	fc06                	sd	ra,56(sp)
     3ec:	f822                	sd	s0,48(sp)
     3ee:	f426                	sd	s1,40(sp)
     3f0:	f04a                	sd	s2,32(sp)
     3f2:	ec4e                	sd	s3,24(sp)
     3f4:	e852                	sd	s4,16(sp)
     3f6:	e456                	sd	s5,8(sp)
     3f8:	e05a                	sd	s6,0(sp)
     3fa:	0080                	addi	s0,sp,64
     3fc:	8a2a                	mv	s4,a0
     3fe:	892e                	mv	s2,a1
     400:	8ab2                	mv	s5,a2
     402:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     404:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     406:	00001997          	auipc	s3,0x1
     40a:	22298993          	addi	s3,s3,546 # 1628 <whitespace>
     40e:	00b4fd63          	bleu	a1,s1,428 <gettoken+0x40>
     412:	0004c583          	lbu	a1,0(s1)
     416:	854e                	mv	a0,s3
     418:	00001097          	auipc	ra,0x1
     41c:	808080e7          	jalr	-2040(ra) # c20 <strchr>
     420:	c501                	beqz	a0,428 <gettoken+0x40>
    s++;
     422:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     424:	fe9917e3          	bne	s2,s1,412 <gettoken+0x2a>
  if(q)
     428:	000a8463          	beqz	s5,430 <gettoken+0x48>
    *q = s;
     42c:	009ab023          	sd	s1,0(s5)
  ret = *s;
     430:	0004c783          	lbu	a5,0(s1)
     434:	00078a9b          	sext.w	s5,a5
  switch(*s){
     438:	02900713          	li	a4,41
     43c:	08f76f63          	bltu	a4,a5,4da <gettoken+0xf2>
     440:	02800713          	li	a4,40
     444:	0ae7f863          	bleu	a4,a5,4f4 <gettoken+0x10c>
     448:	e3b9                	bnez	a5,48e <gettoken+0xa6>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     44a:	000b0463          	beqz	s6,452 <gettoken+0x6a>
    *eq = s;
     44e:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     452:	00001997          	auipc	s3,0x1
     456:	1d698993          	addi	s3,s3,470 # 1628 <whitespace>
     45a:	0124fd63          	bleu	s2,s1,474 <gettoken+0x8c>
     45e:	0004c583          	lbu	a1,0(s1)
     462:	854e                	mv	a0,s3
     464:	00000097          	auipc	ra,0x0
     468:	7bc080e7          	jalr	1980(ra) # c20 <strchr>
     46c:	c501                	beqz	a0,474 <gettoken+0x8c>
    s++;
     46e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     470:	fe9917e3          	bne	s2,s1,45e <gettoken+0x76>
  *ps = s;
     474:	009a3023          	sd	s1,0(s4)
  return ret;
}
     478:	8556                	mv	a0,s5
     47a:	70e2                	ld	ra,56(sp)
     47c:	7442                	ld	s0,48(sp)
     47e:	74a2                	ld	s1,40(sp)
     480:	7902                	ld	s2,32(sp)
     482:	69e2                	ld	s3,24(sp)
     484:	6a42                	ld	s4,16(sp)
     486:	6aa2                	ld	s5,8(sp)
     488:	6b02                	ld	s6,0(sp)
     48a:	6121                	addi	sp,sp,64
     48c:	8082                	ret
  switch(*s){
     48e:	02600713          	li	a4,38
     492:	06e78163          	beq	a5,a4,4f4 <gettoken+0x10c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     496:	00001997          	auipc	s3,0x1
     49a:	19298993          	addi	s3,s3,402 # 1628 <whitespace>
     49e:	00001a97          	auipc	s5,0x1
     4a2:	182a8a93          	addi	s5,s5,386 # 1620 <symbols>
     4a6:	0324f563          	bleu	s2,s1,4d0 <gettoken+0xe8>
     4aa:	0004c583          	lbu	a1,0(s1)
     4ae:	854e                	mv	a0,s3
     4b0:	00000097          	auipc	ra,0x0
     4b4:	770080e7          	jalr	1904(ra) # c20 <strchr>
     4b8:	e53d                	bnez	a0,526 <gettoken+0x13e>
     4ba:	0004c583          	lbu	a1,0(s1)
     4be:	8556                	mv	a0,s5
     4c0:	00000097          	auipc	ra,0x0
     4c4:	760080e7          	jalr	1888(ra) # c20 <strchr>
     4c8:	ed21                	bnez	a0,520 <gettoken+0x138>
      s++;
     4ca:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4cc:	fc991fe3          	bne	s2,s1,4aa <gettoken+0xc2>
  if(eq)
     4d0:	06100a93          	li	s5,97
     4d4:	f60b1de3          	bnez	s6,44e <gettoken+0x66>
     4d8:	bf71                	j	474 <gettoken+0x8c>
  switch(*s){
     4da:	03e00713          	li	a4,62
     4de:	02e78263          	beq	a5,a4,502 <gettoken+0x11a>
     4e2:	00f76b63          	bltu	a4,a5,4f8 <gettoken+0x110>
     4e6:	fc57879b          	addiw	a5,a5,-59
     4ea:	0ff7f793          	andi	a5,a5,255
     4ee:	4705                	li	a4,1
     4f0:	faf763e3          	bltu	a4,a5,496 <gettoken+0xae>
    s++;
     4f4:	0485                	addi	s1,s1,1
    break;
     4f6:	bf91                	j	44a <gettoken+0x62>
  switch(*s){
     4f8:	07c00713          	li	a4,124
     4fc:	fee78ce3          	beq	a5,a4,4f4 <gettoken+0x10c>
     500:	bf59                	j	496 <gettoken+0xae>
    s++;
     502:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     506:	0014c703          	lbu	a4,1(s1)
     50a:	03e00793          	li	a5,62
      s++;
     50e:	0489                	addi	s1,s1,2
      ret = '+';
     510:	02b00a93          	li	s5,43
    if(*s == '>'){
     514:	f2f70be3          	beq	a4,a5,44a <gettoken+0x62>
    s++;
     518:	84b6                	mv	s1,a3
  ret = *s;
     51a:	03e00a93          	li	s5,62
     51e:	b735                	j	44a <gettoken+0x62>
    ret = 'a';
     520:	06100a93          	li	s5,97
     524:	b71d                	j	44a <gettoken+0x62>
     526:	06100a93          	li	s5,97
     52a:	b705                	j	44a <gettoken+0x62>

000000000000052c <peek>:

int
peek(char **ps, char *es, char *toks)
{
     52c:	7139                	addi	sp,sp,-64
     52e:	fc06                	sd	ra,56(sp)
     530:	f822                	sd	s0,48(sp)
     532:	f426                	sd	s1,40(sp)
     534:	f04a                	sd	s2,32(sp)
     536:	ec4e                	sd	s3,24(sp)
     538:	e852                	sd	s4,16(sp)
     53a:	e456                	sd	s5,8(sp)
     53c:	0080                	addi	s0,sp,64
     53e:	8a2a                	mv	s4,a0
     540:	892e                	mv	s2,a1
     542:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     544:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     546:	00001997          	auipc	s3,0x1
     54a:	0e298993          	addi	s3,s3,226 # 1628 <whitespace>
     54e:	00b4fd63          	bleu	a1,s1,568 <peek+0x3c>
     552:	0004c583          	lbu	a1,0(s1)
     556:	854e                	mv	a0,s3
     558:	00000097          	auipc	ra,0x0
     55c:	6c8080e7          	jalr	1736(ra) # c20 <strchr>
     560:	c501                	beqz	a0,568 <peek+0x3c>
    s++;
     562:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     564:	fe9917e3          	bne	s2,s1,552 <peek+0x26>
  *ps = s;
     568:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     56c:	0004c583          	lbu	a1,0(s1)
     570:	4501                	li	a0,0
     572:	e991                	bnez	a1,586 <peek+0x5a>
}
     574:	70e2                	ld	ra,56(sp)
     576:	7442                	ld	s0,48(sp)
     578:	74a2                	ld	s1,40(sp)
     57a:	7902                	ld	s2,32(sp)
     57c:	69e2                	ld	s3,24(sp)
     57e:	6a42                	ld	s4,16(sp)
     580:	6aa2                	ld	s5,8(sp)
     582:	6121                	addi	sp,sp,64
     584:	8082                	ret
  return *s && strchr(toks, *s);
     586:	8556                	mv	a0,s5
     588:	00000097          	auipc	ra,0x0
     58c:	698080e7          	jalr	1688(ra) # c20 <strchr>
     590:	00a03533          	snez	a0,a0
     594:	b7c5                	j	574 <peek+0x48>

0000000000000596 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     596:	7159                	addi	sp,sp,-112
     598:	f486                	sd	ra,104(sp)
     59a:	f0a2                	sd	s0,96(sp)
     59c:	eca6                	sd	s1,88(sp)
     59e:	e8ca                	sd	s2,80(sp)
     5a0:	e4ce                	sd	s3,72(sp)
     5a2:	e0d2                	sd	s4,64(sp)
     5a4:	fc56                	sd	s5,56(sp)
     5a6:	f85a                	sd	s6,48(sp)
     5a8:	f45e                	sd	s7,40(sp)
     5aa:	f062                	sd	s8,32(sp)
     5ac:	ec66                	sd	s9,24(sp)
     5ae:	1880                	addi	s0,sp,112
     5b0:	8b2a                	mv	s6,a0
     5b2:	89ae                	mv	s3,a1
     5b4:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5b6:	00001b97          	auipc	s7,0x1
     5ba:	f82b8b93          	addi	s7,s7,-126 # 1538 <malloc+0x184>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5be:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     5c2:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     5c6:	a02d                	j	5f0 <parseredirs+0x5a>
      panic("missing file for redirection");
     5c8:	00001517          	auipc	a0,0x1
     5cc:	f5050513          	addi	a0,a0,-176 # 1518 <malloc+0x164>
     5d0:	00000097          	auipc	ra,0x0
     5d4:	a90080e7          	jalr	-1392(ra) # 60 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5d8:	4701                	li	a4,0
     5da:	4681                	li	a3,0
     5dc:	f9043603          	ld	a2,-112(s0)
     5e0:	f9843583          	ld	a1,-104(s0)
     5e4:	855a                	mv	a0,s6
     5e6:	00000097          	auipc	ra,0x0
     5ea:	cd2080e7          	jalr	-814(ra) # 2b8 <redircmd>
     5ee:	8b2a                	mv	s6,a0
    switch(tok){
     5f0:	03e00a93          	li	s5,62
     5f4:	02b00a13          	li	s4,43
  while(peek(ps, es, "<>")){
     5f8:	865e                	mv	a2,s7
     5fa:	85ca                	mv	a1,s2
     5fc:	854e                	mv	a0,s3
     5fe:	00000097          	auipc	ra,0x0
     602:	f2e080e7          	jalr	-210(ra) # 52c <peek>
     606:	c925                	beqz	a0,676 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     608:	4681                	li	a3,0
     60a:	4601                	li	a2,0
     60c:	85ca                	mv	a1,s2
     60e:	854e                	mv	a0,s3
     610:	00000097          	auipc	ra,0x0
     614:	dd8080e7          	jalr	-552(ra) # 3e8 <gettoken>
     618:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     61a:	f9040693          	addi	a3,s0,-112
     61e:	f9840613          	addi	a2,s0,-104
     622:	85ca                	mv	a1,s2
     624:	854e                	mv	a0,s3
     626:	00000097          	auipc	ra,0x0
     62a:	dc2080e7          	jalr	-574(ra) # 3e8 <gettoken>
     62e:	f9851de3          	bne	a0,s8,5c8 <parseredirs+0x32>
    switch(tok){
     632:	fb9483e3          	beq	s1,s9,5d8 <parseredirs+0x42>
     636:	03548263          	beq	s1,s5,65a <parseredirs+0xc4>
     63a:	fb449fe3          	bne	s1,s4,5f8 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     63e:	4705                	li	a4,1
     640:	20100693          	li	a3,513
     644:	f9043603          	ld	a2,-112(s0)
     648:	f9843583          	ld	a1,-104(s0)
     64c:	855a                	mv	a0,s6
     64e:	00000097          	auipc	ra,0x0
     652:	c6a080e7          	jalr	-918(ra) # 2b8 <redircmd>
     656:	8b2a                	mv	s6,a0
      break;
     658:	bf61                	j	5f0 <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     65a:	4705                	li	a4,1
     65c:	20100693          	li	a3,513
     660:	f9043603          	ld	a2,-112(s0)
     664:	f9843583          	ld	a1,-104(s0)
     668:	855a                	mv	a0,s6
     66a:	00000097          	auipc	ra,0x0
     66e:	c4e080e7          	jalr	-946(ra) # 2b8 <redircmd>
     672:	8b2a                	mv	s6,a0
      break;
     674:	bfb5                	j	5f0 <parseredirs+0x5a>
    }
  }
  return cmd;
}
     676:	855a                	mv	a0,s6
     678:	70a6                	ld	ra,104(sp)
     67a:	7406                	ld	s0,96(sp)
     67c:	64e6                	ld	s1,88(sp)
     67e:	6946                	ld	s2,80(sp)
     680:	69a6                	ld	s3,72(sp)
     682:	6a06                	ld	s4,64(sp)
     684:	7ae2                	ld	s5,56(sp)
     686:	7b42                	ld	s6,48(sp)
     688:	7ba2                	ld	s7,40(sp)
     68a:	7c02                	ld	s8,32(sp)
     68c:	6ce2                	ld	s9,24(sp)
     68e:	6165                	addi	sp,sp,112
     690:	8082                	ret

0000000000000692 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     692:	7159                	addi	sp,sp,-112
     694:	f486                	sd	ra,104(sp)
     696:	f0a2                	sd	s0,96(sp)
     698:	eca6                	sd	s1,88(sp)
     69a:	e8ca                	sd	s2,80(sp)
     69c:	e4ce                	sd	s3,72(sp)
     69e:	e0d2                	sd	s4,64(sp)
     6a0:	fc56                	sd	s5,56(sp)
     6a2:	f85a                	sd	s6,48(sp)
     6a4:	f45e                	sd	s7,40(sp)
     6a6:	f062                	sd	s8,32(sp)
     6a8:	ec66                	sd	s9,24(sp)
     6aa:	1880                	addi	s0,sp,112
     6ac:	89aa                	mv	s3,a0
     6ae:	8a2e                	mv	s4,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6b0:	00001617          	auipc	a2,0x1
     6b4:	e9060613          	addi	a2,a2,-368 # 1540 <malloc+0x18c>
     6b8:	00000097          	auipc	ra,0x0
     6bc:	e74080e7          	jalr	-396(ra) # 52c <peek>
     6c0:	e905                	bnez	a0,6f0 <parseexec+0x5e>
     6c2:	892a                	mv	s2,a0
    return parseblock(ps, es);

  ret = execcmd();
     6c4:	00000097          	auipc	ra,0x0
     6c8:	bbe080e7          	jalr	-1090(ra) # 282 <execcmd>
     6cc:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6ce:	8652                	mv	a2,s4
     6d0:	85ce                	mv	a1,s3
     6d2:	00000097          	auipc	ra,0x0
     6d6:	ec4080e7          	jalr	-316(ra) # 596 <parseredirs>
     6da:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     6dc:	008c0493          	addi	s1,s8,8
     6e0:	00001b17          	auipc	s6,0x1
     6e4:	e80b0b13          	addi	s6,s6,-384 # 1560 <malloc+0x1ac>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     6e8:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6ec:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     6ee:	a0b1                	j	73a <parseexec+0xa8>
    return parseblock(ps, es);
     6f0:	85d2                	mv	a1,s4
     6f2:	854e                	mv	a0,s3
     6f4:	00000097          	auipc	ra,0x0
     6f8:	1b8080e7          	jalr	440(ra) # 8ac <parseblock>
     6fc:	8aaa                	mv	s5,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     6fe:	8556                	mv	a0,s5
     700:	70a6                	ld	ra,104(sp)
     702:	7406                	ld	s0,96(sp)
     704:	64e6                	ld	s1,88(sp)
     706:	6946                	ld	s2,80(sp)
     708:	69a6                	ld	s3,72(sp)
     70a:	6a06                	ld	s4,64(sp)
     70c:	7ae2                	ld	s5,56(sp)
     70e:	7b42                	ld	s6,48(sp)
     710:	7ba2                	ld	s7,40(sp)
     712:	7c02                	ld	s8,32(sp)
     714:	6ce2                	ld	s9,24(sp)
     716:	6165                	addi	sp,sp,112
     718:	8082                	ret
      panic("syntax");
     71a:	00001517          	auipc	a0,0x1
     71e:	e2e50513          	addi	a0,a0,-466 # 1548 <malloc+0x194>
     722:	00000097          	auipc	ra,0x0
     726:	93e080e7          	jalr	-1730(ra) # 60 <panic>
    ret = parseredirs(ret, ps, es);
     72a:	8652                	mv	a2,s4
     72c:	85ce                	mv	a1,s3
     72e:	8556                	mv	a0,s5
     730:	00000097          	auipc	ra,0x0
     734:	e66080e7          	jalr	-410(ra) # 596 <parseredirs>
     738:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     73a:	865a                	mv	a2,s6
     73c:	85d2                	mv	a1,s4
     73e:	854e                	mv	a0,s3
     740:	00000097          	auipc	ra,0x0
     744:	dec080e7          	jalr	-532(ra) # 52c <peek>
     748:	e121                	bnez	a0,788 <parseexec+0xf6>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     74a:	f9040693          	addi	a3,s0,-112
     74e:	f9840613          	addi	a2,s0,-104
     752:	85d2                	mv	a1,s4
     754:	854e                	mv	a0,s3
     756:	00000097          	auipc	ra,0x0
     75a:	c92080e7          	jalr	-878(ra) # 3e8 <gettoken>
     75e:	c50d                	beqz	a0,788 <parseexec+0xf6>
    if(tok != 'a')
     760:	fb951de3          	bne	a0,s9,71a <parseexec+0x88>
    cmd->argv[argc] = q;
     764:	f9843783          	ld	a5,-104(s0)
     768:	e09c                	sd	a5,0(s1)
    cmd->eargv[argc] = eq;
     76a:	f9043783          	ld	a5,-112(s0)
     76e:	e8bc                	sd	a5,80(s1)
    argc++;
     770:	2905                	addiw	s2,s2,1
    if(argc >= MAXARGS)
     772:	04a1                	addi	s1,s1,8
     774:	fb791be3          	bne	s2,s7,72a <parseexec+0x98>
      panic("too many args");
     778:	00001517          	auipc	a0,0x1
     77c:	dd850513          	addi	a0,a0,-552 # 1550 <malloc+0x19c>
     780:	00000097          	auipc	ra,0x0
     784:	8e0080e7          	jalr	-1824(ra) # 60 <panic>
  cmd->argv[argc] = 0;
     788:	090e                	slli	s2,s2,0x3
     78a:	9962                	add	s2,s2,s8
     78c:	00093423          	sd	zero,8(s2)
  cmd->eargv[argc] = 0;
     790:	04093c23          	sd	zero,88(s2)
  return ret;
     794:	b7ad                	j	6fe <parseexec+0x6c>

0000000000000796 <parsepipe>:
{
     796:	7179                	addi	sp,sp,-48
     798:	f406                	sd	ra,40(sp)
     79a:	f022                	sd	s0,32(sp)
     79c:	ec26                	sd	s1,24(sp)
     79e:	e84a                	sd	s2,16(sp)
     7a0:	e44e                	sd	s3,8(sp)
     7a2:	1800                	addi	s0,sp,48
     7a4:	892a                	mv	s2,a0
     7a6:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     7a8:	00000097          	auipc	ra,0x0
     7ac:	eea080e7          	jalr	-278(ra) # 692 <parseexec>
     7b0:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7b2:	00001617          	auipc	a2,0x1
     7b6:	db660613          	addi	a2,a2,-586 # 1568 <malloc+0x1b4>
     7ba:	85ce                	mv	a1,s3
     7bc:	854a                	mv	a0,s2
     7be:	00000097          	auipc	ra,0x0
     7c2:	d6e080e7          	jalr	-658(ra) # 52c <peek>
     7c6:	e909                	bnez	a0,7d8 <parsepipe+0x42>
}
     7c8:	8526                	mv	a0,s1
     7ca:	70a2                	ld	ra,40(sp)
     7cc:	7402                	ld	s0,32(sp)
     7ce:	64e2                	ld	s1,24(sp)
     7d0:	6942                	ld	s2,16(sp)
     7d2:	69a2                	ld	s3,8(sp)
     7d4:	6145                	addi	sp,sp,48
     7d6:	8082                	ret
    gettoken(ps, es, 0, 0);
     7d8:	4681                	li	a3,0
     7da:	4601                	li	a2,0
     7dc:	85ce                	mv	a1,s3
     7de:	854a                	mv	a0,s2
     7e0:	00000097          	auipc	ra,0x0
     7e4:	c08080e7          	jalr	-1016(ra) # 3e8 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7e8:	85ce                	mv	a1,s3
     7ea:	854a                	mv	a0,s2
     7ec:	00000097          	auipc	ra,0x0
     7f0:	faa080e7          	jalr	-86(ra) # 796 <parsepipe>
     7f4:	85aa                	mv	a1,a0
     7f6:	8526                	mv	a0,s1
     7f8:	00000097          	auipc	ra,0x0
     7fc:	b28080e7          	jalr	-1240(ra) # 320 <pipecmd>
     800:	84aa                	mv	s1,a0
  return cmd;
     802:	b7d9                	j	7c8 <parsepipe+0x32>

0000000000000804 <parseline>:
{
     804:	7179                	addi	sp,sp,-48
     806:	f406                	sd	ra,40(sp)
     808:	f022                	sd	s0,32(sp)
     80a:	ec26                	sd	s1,24(sp)
     80c:	e84a                	sd	s2,16(sp)
     80e:	e44e                	sd	s3,8(sp)
     810:	e052                	sd	s4,0(sp)
     812:	1800                	addi	s0,sp,48
     814:	84aa                	mv	s1,a0
     816:	892e                	mv	s2,a1
  cmd = parsepipe(ps, es);
     818:	00000097          	auipc	ra,0x0
     81c:	f7e080e7          	jalr	-130(ra) # 796 <parsepipe>
     820:	89aa                	mv	s3,a0
  while(peek(ps, es, "&")){
     822:	00001a17          	auipc	s4,0x1
     826:	d4ea0a13          	addi	s4,s4,-690 # 1570 <malloc+0x1bc>
     82a:	8652                	mv	a2,s4
     82c:	85ca                	mv	a1,s2
     82e:	8526                	mv	a0,s1
     830:	00000097          	auipc	ra,0x0
     834:	cfc080e7          	jalr	-772(ra) # 52c <peek>
     838:	c105                	beqz	a0,858 <parseline+0x54>
    gettoken(ps, es, 0, 0);
     83a:	4681                	li	a3,0
     83c:	4601                	li	a2,0
     83e:	85ca                	mv	a1,s2
     840:	8526                	mv	a0,s1
     842:	00000097          	auipc	ra,0x0
     846:	ba6080e7          	jalr	-1114(ra) # 3e8 <gettoken>
    cmd = backcmd(cmd);
     84a:	854e                	mv	a0,s3
     84c:	00000097          	auipc	ra,0x0
     850:	b60080e7          	jalr	-1184(ra) # 3ac <backcmd>
     854:	89aa                	mv	s3,a0
     856:	bfd1                	j	82a <parseline+0x26>
  if(peek(ps, es, ";")){
     858:	00001617          	auipc	a2,0x1
     85c:	d2060613          	addi	a2,a2,-736 # 1578 <malloc+0x1c4>
     860:	85ca                	mv	a1,s2
     862:	8526                	mv	a0,s1
     864:	00000097          	auipc	ra,0x0
     868:	cc8080e7          	jalr	-824(ra) # 52c <peek>
     86c:	e911                	bnez	a0,880 <parseline+0x7c>
}
     86e:	854e                	mv	a0,s3
     870:	70a2                	ld	ra,40(sp)
     872:	7402                	ld	s0,32(sp)
     874:	64e2                	ld	s1,24(sp)
     876:	6942                	ld	s2,16(sp)
     878:	69a2                	ld	s3,8(sp)
     87a:	6a02                	ld	s4,0(sp)
     87c:	6145                	addi	sp,sp,48
     87e:	8082                	ret
    gettoken(ps, es, 0, 0);
     880:	4681                	li	a3,0
     882:	4601                	li	a2,0
     884:	85ca                	mv	a1,s2
     886:	8526                	mv	a0,s1
     888:	00000097          	auipc	ra,0x0
     88c:	b60080e7          	jalr	-1184(ra) # 3e8 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     890:	85ca                	mv	a1,s2
     892:	8526                	mv	a0,s1
     894:	00000097          	auipc	ra,0x0
     898:	f70080e7          	jalr	-144(ra) # 804 <parseline>
     89c:	85aa                	mv	a1,a0
     89e:	854e                	mv	a0,s3
     8a0:	00000097          	auipc	ra,0x0
     8a4:	ac6080e7          	jalr	-1338(ra) # 366 <listcmd>
     8a8:	89aa                	mv	s3,a0
  return cmd;
     8aa:	b7d1                	j	86e <parseline+0x6a>

00000000000008ac <parseblock>:
{
     8ac:	7179                	addi	sp,sp,-48
     8ae:	f406                	sd	ra,40(sp)
     8b0:	f022                	sd	s0,32(sp)
     8b2:	ec26                	sd	s1,24(sp)
     8b4:	e84a                	sd	s2,16(sp)
     8b6:	e44e                	sd	s3,8(sp)
     8b8:	1800                	addi	s0,sp,48
     8ba:	84aa                	mv	s1,a0
     8bc:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8be:	00001617          	auipc	a2,0x1
     8c2:	c8260613          	addi	a2,a2,-894 # 1540 <malloc+0x18c>
     8c6:	00000097          	auipc	ra,0x0
     8ca:	c66080e7          	jalr	-922(ra) # 52c <peek>
     8ce:	c12d                	beqz	a0,930 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8d0:	4681                	li	a3,0
     8d2:	4601                	li	a2,0
     8d4:	85ca                	mv	a1,s2
     8d6:	8526                	mv	a0,s1
     8d8:	00000097          	auipc	ra,0x0
     8dc:	b10080e7          	jalr	-1264(ra) # 3e8 <gettoken>
  cmd = parseline(ps, es);
     8e0:	85ca                	mv	a1,s2
     8e2:	8526                	mv	a0,s1
     8e4:	00000097          	auipc	ra,0x0
     8e8:	f20080e7          	jalr	-224(ra) # 804 <parseline>
     8ec:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     8ee:	00001617          	auipc	a2,0x1
     8f2:	ca260613          	addi	a2,a2,-862 # 1590 <malloc+0x1dc>
     8f6:	85ca                	mv	a1,s2
     8f8:	8526                	mv	a0,s1
     8fa:	00000097          	auipc	ra,0x0
     8fe:	c32080e7          	jalr	-974(ra) # 52c <peek>
     902:	cd1d                	beqz	a0,940 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     904:	4681                	li	a3,0
     906:	4601                	li	a2,0
     908:	85ca                	mv	a1,s2
     90a:	8526                	mv	a0,s1
     90c:	00000097          	auipc	ra,0x0
     910:	adc080e7          	jalr	-1316(ra) # 3e8 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     914:	864a                	mv	a2,s2
     916:	85a6                	mv	a1,s1
     918:	854e                	mv	a0,s3
     91a:	00000097          	auipc	ra,0x0
     91e:	c7c080e7          	jalr	-900(ra) # 596 <parseredirs>
}
     922:	70a2                	ld	ra,40(sp)
     924:	7402                	ld	s0,32(sp)
     926:	64e2                	ld	s1,24(sp)
     928:	6942                	ld	s2,16(sp)
     92a:	69a2                	ld	s3,8(sp)
     92c:	6145                	addi	sp,sp,48
     92e:	8082                	ret
    panic("parseblock");
     930:	00001517          	auipc	a0,0x1
     934:	c5050513          	addi	a0,a0,-944 # 1580 <malloc+0x1cc>
     938:	fffff097          	auipc	ra,0xfffff
     93c:	728080e7          	jalr	1832(ra) # 60 <panic>
    panic("syntax - missing )");
     940:	00001517          	auipc	a0,0x1
     944:	c5850513          	addi	a0,a0,-936 # 1598 <malloc+0x1e4>
     948:	fffff097          	auipc	ra,0xfffff
     94c:	718080e7          	jalr	1816(ra) # 60 <panic>

0000000000000950 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     950:	1101                	addi	sp,sp,-32
     952:	ec06                	sd	ra,24(sp)
     954:	e822                	sd	s0,16(sp)
     956:	e426                	sd	s1,8(sp)
     958:	1000                	addi	s0,sp,32
     95a:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     95c:	c521                	beqz	a0,9a4 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     95e:	4118                	lw	a4,0(a0)
     960:	4795                	li	a5,5
     962:	04e7e163          	bltu	a5,a4,9a4 <nulterminate+0x54>
     966:	00056783          	lwu	a5,0(a0)
     96a:	078a                	slli	a5,a5,0x2
     96c:	00001717          	auipc	a4,0x1
     970:	b4c70713          	addi	a4,a4,-1204 # 14b8 <malloc+0x104>
     974:	97ba                	add	a5,a5,a4
     976:	439c                	lw	a5,0(a5)
     978:	97ba                	add	a5,a5,a4
     97a:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     97c:	651c                	ld	a5,8(a0)
     97e:	c39d                	beqz	a5,9a4 <nulterminate+0x54>
     980:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     984:	67b8                	ld	a4,72(a5)
     986:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     98a:	07a1                	addi	a5,a5,8
     98c:	ff87b703          	ld	a4,-8(a5)
     990:	fb75                	bnez	a4,984 <nulterminate+0x34>
     992:	a809                	j	9a4 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     994:	6508                	ld	a0,8(a0)
     996:	00000097          	auipc	ra,0x0
     99a:	fba080e7          	jalr	-70(ra) # 950 <nulterminate>
    *rcmd->efile = 0;
     99e:	6c9c                	ld	a5,24(s1)
     9a0:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9a4:	8526                	mv	a0,s1
     9a6:	60e2                	ld	ra,24(sp)
     9a8:	6442                	ld	s0,16(sp)
     9aa:	64a2                	ld	s1,8(sp)
     9ac:	6105                	addi	sp,sp,32
     9ae:	8082                	ret
    nulterminate(pcmd->left);
     9b0:	6508                	ld	a0,8(a0)
     9b2:	00000097          	auipc	ra,0x0
     9b6:	f9e080e7          	jalr	-98(ra) # 950 <nulterminate>
    nulterminate(pcmd->right);
     9ba:	6888                	ld	a0,16(s1)
     9bc:	00000097          	auipc	ra,0x0
     9c0:	f94080e7          	jalr	-108(ra) # 950 <nulterminate>
    break;
     9c4:	b7c5                	j	9a4 <nulterminate+0x54>
    nulterminate(lcmd->left);
     9c6:	6508                	ld	a0,8(a0)
     9c8:	00000097          	auipc	ra,0x0
     9cc:	f88080e7          	jalr	-120(ra) # 950 <nulterminate>
    nulterminate(lcmd->right);
     9d0:	6888                	ld	a0,16(s1)
     9d2:	00000097          	auipc	ra,0x0
     9d6:	f7e080e7          	jalr	-130(ra) # 950 <nulterminate>
    break;
     9da:	b7e9                	j	9a4 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9dc:	6508                	ld	a0,8(a0)
     9de:	00000097          	auipc	ra,0x0
     9e2:	f72080e7          	jalr	-142(ra) # 950 <nulterminate>
    break;
     9e6:	bf7d                	j	9a4 <nulterminate+0x54>

00000000000009e8 <parsecmd>:
{
     9e8:	7179                	addi	sp,sp,-48
     9ea:	f406                	sd	ra,40(sp)
     9ec:	f022                	sd	s0,32(sp)
     9ee:	ec26                	sd	s1,24(sp)
     9f0:	e84a                	sd	s2,16(sp)
     9f2:	1800                	addi	s0,sp,48
     9f4:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     9f8:	84aa                	mv	s1,a0
     9fa:	00000097          	auipc	ra,0x0
     9fe:	1d6080e7          	jalr	470(ra) # bd0 <strlen>
     a02:	1502                	slli	a0,a0,0x20
     a04:	9101                	srli	a0,a0,0x20
     a06:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     a08:	85a6                	mv	a1,s1
     a0a:	fd840513          	addi	a0,s0,-40
     a0e:	00000097          	auipc	ra,0x0
     a12:	df6080e7          	jalr	-522(ra) # 804 <parseline>
     a16:	892a                	mv	s2,a0
  peek(&s, es, "");
     a18:	00001617          	auipc	a2,0x1
     a1c:	b9860613          	addi	a2,a2,-1128 # 15b0 <malloc+0x1fc>
     a20:	85a6                	mv	a1,s1
     a22:	fd840513          	addi	a0,s0,-40
     a26:	00000097          	auipc	ra,0x0
     a2a:	b06080e7          	jalr	-1274(ra) # 52c <peek>
  if(s != es){
     a2e:	fd843603          	ld	a2,-40(s0)
     a32:	00961e63          	bne	a2,s1,a4e <parsecmd+0x66>
  nulterminate(cmd);
     a36:	854a                	mv	a0,s2
     a38:	00000097          	auipc	ra,0x0
     a3c:	f18080e7          	jalr	-232(ra) # 950 <nulterminate>
}
     a40:	854a                	mv	a0,s2
     a42:	70a2                	ld	ra,40(sp)
     a44:	7402                	ld	s0,32(sp)
     a46:	64e2                	ld	s1,24(sp)
     a48:	6942                	ld	s2,16(sp)
     a4a:	6145                	addi	sp,sp,48
     a4c:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a4e:	00001597          	auipc	a1,0x1
     a52:	b6a58593          	addi	a1,a1,-1174 # 15b8 <malloc+0x204>
     a56:	4509                	li	a0,2
     a58:	00001097          	auipc	ra,0x1
     a5c:	86e080e7          	jalr	-1938(ra) # 12c6 <fprintf>
    panic("syntax");
     a60:	00001517          	auipc	a0,0x1
     a64:	ae850513          	addi	a0,a0,-1304 # 1548 <malloc+0x194>
     a68:	fffff097          	auipc	ra,0xfffff
     a6c:	5f8080e7          	jalr	1528(ra) # 60 <panic>

0000000000000a70 <main>:
{
     a70:	7139                	addi	sp,sp,-64
     a72:	fc06                	sd	ra,56(sp)
     a74:	f822                	sd	s0,48(sp)
     a76:	f426                	sd	s1,40(sp)
     a78:	f04a                	sd	s2,32(sp)
     a7a:	ec4e                	sd	s3,24(sp)
     a7c:	e852                	sd	s4,16(sp)
     a7e:	e456                	sd	s5,8(sp)
     a80:	0080                	addi	s0,sp,64
     a82:	84ae                	mv	s1,a1
  if (argc < 2){
     a84:	4785                	li	a5,1
     a86:	04a7d263          	ble	a0,a5,aca <main+0x5a>
  while((fd = open(argv[1], O_RDWR)) >= 0){
     a8a:	4589                	li	a1,2
     a8c:	6488                	ld	a0,8(s1)
     a8e:	00000097          	auipc	ra,0x0
     a92:	410080e7          	jalr	1040(ra) # e9e <open>
     a96:	00054963          	bltz	a0,aa8 <main+0x38>
    if(fd >= 3){
     a9a:	4789                	li	a5,2
     a9c:	fea7d7e3          	ble	a0,a5,a8a <main+0x1a>
      close(fd);
     aa0:	00000097          	auipc	ra,0x0
     aa4:	322080e7          	jalr	802(ra) # dc2 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     aa8:	00001497          	auipc	s1,0x1
     aac:	b9048493          	addi	s1,s1,-1136 # 1638 <buf.1179>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ab0:	06300913          	li	s2,99
     ab4:	02000993          	li	s3,32
      if(chdir(buf+3) < 0)
     ab8:	00001a17          	auipc	s4,0x1
     abc:	b83a0a13          	addi	s4,s4,-1149 # 163b <buf.1179+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     ac0:	00001a97          	auipc	s5,0x1
     ac4:	b30a8a93          	addi	s5,s5,-1232 # 15f0 <malloc+0x23c>
     ac8:	a80d                	j	afa <main+0x8a>
    printf("expected one argument, got argc=%d\n", argc);
     aca:	85aa                	mv	a1,a0
     acc:	00001517          	auipc	a0,0x1
     ad0:	afc50513          	addi	a0,a0,-1284 # 15c8 <malloc+0x214>
     ad4:	00001097          	auipc	ra,0x1
     ad8:	820080e7          	jalr	-2016(ra) # 12f4 <printf>
    exit(-1);
     adc:	557d                	li	a0,-1
     ade:	00000097          	auipc	ra,0x0
     ae2:	380080e7          	jalr	896(ra) # e5e <exit>
    if(fork1() == 0)
     ae6:	fffff097          	auipc	ra,0xfffff
     aea:	5a0080e7          	jalr	1440(ra) # 86 <fork1>
     aee:	c925                	beqz	a0,b5e <main+0xee>
    wait(0);
     af0:	4501                	li	a0,0
     af2:	00000097          	auipc	ra,0x0
     af6:	374080e7          	jalr	884(ra) # e66 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     afa:	06400593          	li	a1,100
     afe:	8526                	mv	a0,s1
     b00:	fffff097          	auipc	ra,0xfffff
     b04:	500080e7          	jalr	1280(ra) # 0 <getcmd>
     b08:	06054763          	bltz	a0,b76 <main+0x106>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     b0c:	0004c783          	lbu	a5,0(s1)
     b10:	fd279be3          	bne	a5,s2,ae6 <main+0x76>
     b14:	0014c703          	lbu	a4,1(s1)
     b18:	06400793          	li	a5,100
     b1c:	fcf715e3          	bne	a4,a5,ae6 <main+0x76>
     b20:	0024c783          	lbu	a5,2(s1)
     b24:	fd3791e3          	bne	a5,s3,ae6 <main+0x76>
      buf[strlen(buf)-1] = 0;  // chop \n
     b28:	8526                	mv	a0,s1
     b2a:	00000097          	auipc	ra,0x0
     b2e:	0a6080e7          	jalr	166(ra) # bd0 <strlen>
     b32:	fff5079b          	addiw	a5,a0,-1
     b36:	1782                	slli	a5,a5,0x20
     b38:	9381                	srli	a5,a5,0x20
     b3a:	97a6                	add	a5,a5,s1
     b3c:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     b40:	8552                	mv	a0,s4
     b42:	00000097          	auipc	ra,0x0
     b46:	38c080e7          	jalr	908(ra) # ece <chdir>
     b4a:	fa0558e3          	bgez	a0,afa <main+0x8a>
        fprintf(2, "cannot cd %s\n", buf+3);
     b4e:	8652                	mv	a2,s4
     b50:	85d6                	mv	a1,s5
     b52:	4509                	li	a0,2
     b54:	00000097          	auipc	ra,0x0
     b58:	772080e7          	jalr	1906(ra) # 12c6 <fprintf>
     b5c:	bf79                	j	afa <main+0x8a>
      runcmd(parsecmd(buf));
     b5e:	00001517          	auipc	a0,0x1
     b62:	ada50513          	addi	a0,a0,-1318 # 1638 <buf.1179>
     b66:	00000097          	auipc	ra,0x0
     b6a:	e82080e7          	jalr	-382(ra) # 9e8 <parsecmd>
     b6e:	fffff097          	auipc	ra,0xfffff
     b72:	546080e7          	jalr	1350(ra) # b4 <runcmd>
  exit(0);
     b76:	4501                	li	a0,0
     b78:	00000097          	auipc	ra,0x0
     b7c:	2e6080e7          	jalr	742(ra) # e5e <exit>

0000000000000b80 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     b80:	1141                	addi	sp,sp,-16
     b82:	e422                	sd	s0,8(sp)
     b84:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b86:	87aa                	mv	a5,a0
     b88:	0585                	addi	a1,a1,1
     b8a:	0785                	addi	a5,a5,1
     b8c:	fff5c703          	lbu	a4,-1(a1)
     b90:	fee78fa3          	sb	a4,-1(a5)
     b94:	fb75                	bnez	a4,b88 <strcpy+0x8>
    ;
  return os;
}
     b96:	6422                	ld	s0,8(sp)
     b98:	0141                	addi	sp,sp,16
     b9a:	8082                	ret

0000000000000b9c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b9c:	1141                	addi	sp,sp,-16
     b9e:	e422                	sd	s0,8(sp)
     ba0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     ba2:	00054783          	lbu	a5,0(a0)
     ba6:	cf91                	beqz	a5,bc2 <strcmp+0x26>
     ba8:	0005c703          	lbu	a4,0(a1)
     bac:	00f71b63          	bne	a4,a5,bc2 <strcmp+0x26>
    p++, q++;
     bb0:	0505                	addi	a0,a0,1
     bb2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     bb4:	00054783          	lbu	a5,0(a0)
     bb8:	c789                	beqz	a5,bc2 <strcmp+0x26>
     bba:	0005c703          	lbu	a4,0(a1)
     bbe:	fef709e3          	beq	a4,a5,bb0 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
     bc2:	0005c503          	lbu	a0,0(a1)
}
     bc6:	40a7853b          	subw	a0,a5,a0
     bca:	6422                	ld	s0,8(sp)
     bcc:	0141                	addi	sp,sp,16
     bce:	8082                	ret

0000000000000bd0 <strlen>:

uint
strlen(const char *s)
{
     bd0:	1141                	addi	sp,sp,-16
     bd2:	e422                	sd	s0,8(sp)
     bd4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bd6:	00054783          	lbu	a5,0(a0)
     bda:	cf91                	beqz	a5,bf6 <strlen+0x26>
     bdc:	0505                	addi	a0,a0,1
     bde:	87aa                	mv	a5,a0
     be0:	4685                	li	a3,1
     be2:	9e89                	subw	a3,a3,a0
     be4:	00f6853b          	addw	a0,a3,a5
     be8:	0785                	addi	a5,a5,1
     bea:	fff7c703          	lbu	a4,-1(a5)
     bee:	fb7d                	bnez	a4,be4 <strlen+0x14>
    ;
  return n;
}
     bf0:	6422                	ld	s0,8(sp)
     bf2:	0141                	addi	sp,sp,16
     bf4:	8082                	ret
  for(n = 0; s[n]; n++)
     bf6:	4501                	li	a0,0
     bf8:	bfe5                	j	bf0 <strlen+0x20>

0000000000000bfa <memset>:

void*
memset(void *dst, int c, uint n)
{
     bfa:	1141                	addi	sp,sp,-16
     bfc:	e422                	sd	s0,8(sp)
     bfe:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c00:	ce09                	beqz	a2,c1a <memset+0x20>
     c02:	87aa                	mv	a5,a0
     c04:	fff6071b          	addiw	a4,a2,-1
     c08:	1702                	slli	a4,a4,0x20
     c0a:	9301                	srli	a4,a4,0x20
     c0c:	0705                	addi	a4,a4,1
     c0e:	972a                	add	a4,a4,a0
    cdst[i] = c;
     c10:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c14:	0785                	addi	a5,a5,1
     c16:	fee79de3          	bne	a5,a4,c10 <memset+0x16>
  }
  return dst;
}
     c1a:	6422                	ld	s0,8(sp)
     c1c:	0141                	addi	sp,sp,16
     c1e:	8082                	ret

0000000000000c20 <strchr>:

char*
strchr(const char *s, char c)
{
     c20:	1141                	addi	sp,sp,-16
     c22:	e422                	sd	s0,8(sp)
     c24:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c26:	00054783          	lbu	a5,0(a0)
     c2a:	cf91                	beqz	a5,c46 <strchr+0x26>
    if(*s == c)
     c2c:	00f58a63          	beq	a1,a5,c40 <strchr+0x20>
  for(; *s; s++)
     c30:	0505                	addi	a0,a0,1
     c32:	00054783          	lbu	a5,0(a0)
     c36:	c781                	beqz	a5,c3e <strchr+0x1e>
    if(*s == c)
     c38:	feb79ce3          	bne	a5,a1,c30 <strchr+0x10>
     c3c:	a011                	j	c40 <strchr+0x20>
      return (char*)s;
  return 0;
     c3e:	4501                	li	a0,0
}
     c40:	6422                	ld	s0,8(sp)
     c42:	0141                	addi	sp,sp,16
     c44:	8082                	ret
  return 0;
     c46:	4501                	li	a0,0
     c48:	bfe5                	j	c40 <strchr+0x20>

0000000000000c4a <gets>:

char*
gets(char *buf, int max)
{
     c4a:	711d                	addi	sp,sp,-96
     c4c:	ec86                	sd	ra,88(sp)
     c4e:	e8a2                	sd	s0,80(sp)
     c50:	e4a6                	sd	s1,72(sp)
     c52:	e0ca                	sd	s2,64(sp)
     c54:	fc4e                	sd	s3,56(sp)
     c56:	f852                	sd	s4,48(sp)
     c58:	f456                	sd	s5,40(sp)
     c5a:	f05a                	sd	s6,32(sp)
     c5c:	ec5e                	sd	s7,24(sp)
     c5e:	1080                	addi	s0,sp,96
     c60:	8baa                	mv	s7,a0
     c62:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c64:	892a                	mv	s2,a0
     c66:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c68:	4aa9                	li	s5,10
     c6a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c6c:	0019849b          	addiw	s1,s3,1
     c70:	0344d863          	ble	s4,s1,ca0 <gets+0x56>
    cc = read(0, &c, 1);
     c74:	4605                	li	a2,1
     c76:	faf40593          	addi	a1,s0,-81
     c7a:	4501                	li	a0,0
     c7c:	00000097          	auipc	ra,0x0
     c80:	1fa080e7          	jalr	506(ra) # e76 <read>
    if(cc < 1)
     c84:	00a05e63          	blez	a0,ca0 <gets+0x56>
    buf[i++] = c;
     c88:	faf44783          	lbu	a5,-81(s0)
     c8c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     c90:	01578763          	beq	a5,s5,c9e <gets+0x54>
     c94:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
     c96:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
     c98:	fd679ae3          	bne	a5,s6,c6c <gets+0x22>
     c9c:	a011                	j	ca0 <gets+0x56>
  for(i=0; i+1 < max; ){
     c9e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     ca0:	99de                	add	s3,s3,s7
     ca2:	00098023          	sb	zero,0(s3)
  return buf;
}
     ca6:	855e                	mv	a0,s7
     ca8:	60e6                	ld	ra,88(sp)
     caa:	6446                	ld	s0,80(sp)
     cac:	64a6                	ld	s1,72(sp)
     cae:	6906                	ld	s2,64(sp)
     cb0:	79e2                	ld	s3,56(sp)
     cb2:	7a42                	ld	s4,48(sp)
     cb4:	7aa2                	ld	s5,40(sp)
     cb6:	7b02                	ld	s6,32(sp)
     cb8:	6be2                	ld	s7,24(sp)
     cba:	6125                	addi	sp,sp,96
     cbc:	8082                	ret

0000000000000cbe <atoi>:
  return r;
}

int
atoi(const char *s)
{
     cbe:	1141                	addi	sp,sp,-16
     cc0:	e422                	sd	s0,8(sp)
     cc2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cc4:	00054683          	lbu	a3,0(a0)
     cc8:	fd06879b          	addiw	a5,a3,-48
     ccc:	0ff7f793          	andi	a5,a5,255
     cd0:	4725                	li	a4,9
     cd2:	02f76963          	bltu	a4,a5,d04 <atoi+0x46>
     cd6:	862a                	mv	a2,a0
  n = 0;
     cd8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     cda:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     cdc:	0605                	addi	a2,a2,1
     cde:	0025179b          	slliw	a5,a0,0x2
     ce2:	9fa9                	addw	a5,a5,a0
     ce4:	0017979b          	slliw	a5,a5,0x1
     ce8:	9fb5                	addw	a5,a5,a3
     cea:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     cee:	00064683          	lbu	a3,0(a2)
     cf2:	fd06871b          	addiw	a4,a3,-48
     cf6:	0ff77713          	andi	a4,a4,255
     cfa:	fee5f1e3          	bleu	a4,a1,cdc <atoi+0x1e>
  return n;
}
     cfe:	6422                	ld	s0,8(sp)
     d00:	0141                	addi	sp,sp,16
     d02:	8082                	ret
  n = 0;
     d04:	4501                	li	a0,0
     d06:	bfe5                	j	cfe <atoi+0x40>

0000000000000d08 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d08:	1141                	addi	sp,sp,-16
     d0a:	e422                	sd	s0,8(sp)
     d0c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d0e:	02b57663          	bleu	a1,a0,d3a <memmove+0x32>
    while(n-- > 0)
     d12:	02c05163          	blez	a2,d34 <memmove+0x2c>
     d16:	fff6079b          	addiw	a5,a2,-1
     d1a:	1782                	slli	a5,a5,0x20
     d1c:	9381                	srli	a5,a5,0x20
     d1e:	0785                	addi	a5,a5,1
     d20:	97aa                	add	a5,a5,a0
  dst = vdst;
     d22:	872a                	mv	a4,a0
      *dst++ = *src++;
     d24:	0585                	addi	a1,a1,1
     d26:	0705                	addi	a4,a4,1
     d28:	fff5c683          	lbu	a3,-1(a1)
     d2c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d30:	fee79ae3          	bne	a5,a4,d24 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     d34:	6422                	ld	s0,8(sp)
     d36:	0141                	addi	sp,sp,16
     d38:	8082                	ret
    dst += n;
     d3a:	00c50733          	add	a4,a0,a2
    src += n;
     d3e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     d40:	fec05ae3          	blez	a2,d34 <memmove+0x2c>
     d44:	fff6079b          	addiw	a5,a2,-1
     d48:	1782                	slli	a5,a5,0x20
     d4a:	9381                	srli	a5,a5,0x20
     d4c:	fff7c793          	not	a5,a5
     d50:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     d52:	15fd                	addi	a1,a1,-1
     d54:	177d                	addi	a4,a4,-1
     d56:	0005c683          	lbu	a3,0(a1)
     d5a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     d5e:	fef71ae3          	bne	a4,a5,d52 <memmove+0x4a>
     d62:	bfc9                	j	d34 <memmove+0x2c>

0000000000000d64 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     d64:	1141                	addi	sp,sp,-16
     d66:	e422                	sd	s0,8(sp)
     d68:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     d6a:	ce15                	beqz	a2,da6 <memcmp+0x42>
     d6c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
     d70:	00054783          	lbu	a5,0(a0)
     d74:	0005c703          	lbu	a4,0(a1)
     d78:	02e79063          	bne	a5,a4,d98 <memcmp+0x34>
     d7c:	1682                	slli	a3,a3,0x20
     d7e:	9281                	srli	a3,a3,0x20
     d80:	0685                	addi	a3,a3,1
     d82:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
     d84:	0505                	addi	a0,a0,1
    p2++;
     d86:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     d88:	00d50d63          	beq	a0,a3,da2 <memcmp+0x3e>
    if (*p1 != *p2) {
     d8c:	00054783          	lbu	a5,0(a0)
     d90:	0005c703          	lbu	a4,0(a1)
     d94:	fee788e3          	beq	a5,a4,d84 <memcmp+0x20>
      return *p1 - *p2;
     d98:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
     d9c:	6422                	ld	s0,8(sp)
     d9e:	0141                	addi	sp,sp,16
     da0:	8082                	ret
  return 0;
     da2:	4501                	li	a0,0
     da4:	bfe5                	j	d9c <memcmp+0x38>
     da6:	4501                	li	a0,0
     da8:	bfd5                	j	d9c <memcmp+0x38>

0000000000000daa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     daa:	1141                	addi	sp,sp,-16
     dac:	e406                	sd	ra,8(sp)
     dae:	e022                	sd	s0,0(sp)
     db0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     db2:	00000097          	auipc	ra,0x0
     db6:	f56080e7          	jalr	-170(ra) # d08 <memmove>
}
     dba:	60a2                	ld	ra,8(sp)
     dbc:	6402                	ld	s0,0(sp)
     dbe:	0141                	addi	sp,sp,16
     dc0:	8082                	ret

0000000000000dc2 <close>:

int close(int fd){
     dc2:	1101                	addi	sp,sp,-32
     dc4:	ec06                	sd	ra,24(sp)
     dc6:	e822                	sd	s0,16(sp)
     dc8:	e426                	sd	s1,8(sp)
     dca:	1000                	addi	s0,sp,32
     dcc:	84aa                	mv	s1,a0
  fflush(fd);
     dce:	00000097          	auipc	ra,0x0
     dd2:	2da080e7          	jalr	730(ra) # 10a8 <fflush>
  char* buf = get_putc_buf(fd);
     dd6:	8526                	mv	a0,s1
     dd8:	00000097          	auipc	ra,0x0
     ddc:	14e080e7          	jalr	334(ra) # f26 <get_putc_buf>
  if(buf){
     de0:	cd11                	beqz	a0,dfc <close+0x3a>
    free(buf);
     de2:	00000097          	auipc	ra,0x0
     de6:	548080e7          	jalr	1352(ra) # 132a <free>
    putc_buf[fd] = 0;
     dea:	00349713          	slli	a4,s1,0x3
     dee:	00001797          	auipc	a5,0x1
     df2:	8b278793          	addi	a5,a5,-1870 # 16a0 <putc_buf>
     df6:	97ba                	add	a5,a5,a4
     df8:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
     dfc:	8526                	mv	a0,s1
     dfe:	00000097          	auipc	ra,0x0
     e02:	088080e7          	jalr	136(ra) # e86 <sclose>
}
     e06:	60e2                	ld	ra,24(sp)
     e08:	6442                	ld	s0,16(sp)
     e0a:	64a2                	ld	s1,8(sp)
     e0c:	6105                	addi	sp,sp,32
     e0e:	8082                	ret

0000000000000e10 <stat>:
{
     e10:	1101                	addi	sp,sp,-32
     e12:	ec06                	sd	ra,24(sp)
     e14:	e822                	sd	s0,16(sp)
     e16:	e426                	sd	s1,8(sp)
     e18:	e04a                	sd	s2,0(sp)
     e1a:	1000                	addi	s0,sp,32
     e1c:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
     e1e:	4581                	li	a1,0
     e20:	00000097          	auipc	ra,0x0
     e24:	07e080e7          	jalr	126(ra) # e9e <open>
  if(fd < 0)
     e28:	02054563          	bltz	a0,e52 <stat+0x42>
     e2c:	84aa                	mv	s1,a0
  r = fstat(fd, st);
     e2e:	85ca                	mv	a1,s2
     e30:	00000097          	auipc	ra,0x0
     e34:	086080e7          	jalr	134(ra) # eb6 <fstat>
     e38:	892a                	mv	s2,a0
  close(fd);
     e3a:	8526                	mv	a0,s1
     e3c:	00000097          	auipc	ra,0x0
     e40:	f86080e7          	jalr	-122(ra) # dc2 <close>
}
     e44:	854a                	mv	a0,s2
     e46:	60e2                	ld	ra,24(sp)
     e48:	6442                	ld	s0,16(sp)
     e4a:	64a2                	ld	s1,8(sp)
     e4c:	6902                	ld	s2,0(sp)
     e4e:	6105                	addi	sp,sp,32
     e50:	8082                	ret
    return -1;
     e52:	597d                	li	s2,-1
     e54:	bfc5                	j	e44 <stat+0x34>

0000000000000e56 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e56:	4885                	li	a7,1
 ecall
     e58:	00000073          	ecall
 ret
     e5c:	8082                	ret

0000000000000e5e <exit>:
.global exit
exit:
 li a7, SYS_exit
     e5e:	4889                	li	a7,2
 ecall
     e60:	00000073          	ecall
 ret
     e64:	8082                	ret

0000000000000e66 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e66:	488d                	li	a7,3
 ecall
     e68:	00000073          	ecall
 ret
     e6c:	8082                	ret

0000000000000e6e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e6e:	4891                	li	a7,4
 ecall
     e70:	00000073          	ecall
 ret
     e74:	8082                	ret

0000000000000e76 <read>:
.global read
read:
 li a7, SYS_read
     e76:	4895                	li	a7,5
 ecall
     e78:	00000073          	ecall
 ret
     e7c:	8082                	ret

0000000000000e7e <write>:
.global write
write:
 li a7, SYS_write
     e7e:	48c1                	li	a7,16
 ecall
     e80:	00000073          	ecall
 ret
     e84:	8082                	ret

0000000000000e86 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
     e86:	48d5                	li	a7,21
 ecall
     e88:	00000073          	ecall
 ret
     e8c:	8082                	ret

0000000000000e8e <kill>:
.global kill
kill:
 li a7, SYS_kill
     e8e:	4899                	li	a7,6
 ecall
     e90:	00000073          	ecall
 ret
     e94:	8082                	ret

0000000000000e96 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e96:	489d                	li	a7,7
 ecall
     e98:	00000073          	ecall
 ret
     e9c:	8082                	ret

0000000000000e9e <open>:
.global open
open:
 li a7, SYS_open
     e9e:	48bd                	li	a7,15
 ecall
     ea0:	00000073          	ecall
 ret
     ea4:	8082                	ret

0000000000000ea6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     ea6:	48c5                	li	a7,17
 ecall
     ea8:	00000073          	ecall
 ret
     eac:	8082                	ret

0000000000000eae <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     eae:	48c9                	li	a7,18
 ecall
     eb0:	00000073          	ecall
 ret
     eb4:	8082                	ret

0000000000000eb6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     eb6:	48a1                	li	a7,8
 ecall
     eb8:	00000073          	ecall
 ret
     ebc:	8082                	ret

0000000000000ebe <link>:
.global link
link:
 li a7, SYS_link
     ebe:	48cd                	li	a7,19
 ecall
     ec0:	00000073          	ecall
 ret
     ec4:	8082                	ret

0000000000000ec6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     ec6:	48d1                	li	a7,20
 ecall
     ec8:	00000073          	ecall
 ret
     ecc:	8082                	ret

0000000000000ece <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     ece:	48a5                	li	a7,9
 ecall
     ed0:	00000073          	ecall
 ret
     ed4:	8082                	ret

0000000000000ed6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     ed6:	48a9                	li	a7,10
 ecall
     ed8:	00000073          	ecall
 ret
     edc:	8082                	ret

0000000000000ede <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     ede:	48ad                	li	a7,11
 ecall
     ee0:	00000073          	ecall
 ret
     ee4:	8082                	ret

0000000000000ee6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     ee6:	48b1                	li	a7,12
 ecall
     ee8:	00000073          	ecall
 ret
     eec:	8082                	ret

0000000000000eee <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     eee:	48b5                	li	a7,13
 ecall
     ef0:	00000073          	ecall
 ret
     ef4:	8082                	ret

0000000000000ef6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ef6:	48b9                	li	a7,14
 ecall
     ef8:	00000073          	ecall
 ret
     efc:	8082                	ret

0000000000000efe <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
     efe:	48d9                	li	a7,22
 ecall
     f00:	00000073          	ecall
 ret
     f04:	8082                	ret

0000000000000f06 <nice>:
.global nice
nice:
 li a7, SYS_nice
     f06:	48dd                	li	a7,23
 ecall
     f08:	00000073          	ecall
 ret
     f0c:	8082                	ret

0000000000000f0e <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
     f0e:	48e1                	li	a7,24
 ecall
     f10:	00000073          	ecall
 ret
     f14:	8082                	ret

0000000000000f16 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
     f16:	48e5                	li	a7,25
 ecall
     f18:	00000073          	ecall
 ret
     f1c:	8082                	ret

0000000000000f1e <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
     f1e:	48e9                	li	a7,26
 ecall
     f20:	00000073          	ecall
 ret
     f24:	8082                	ret

0000000000000f26 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
     f26:	1101                	addi	sp,sp,-32
     f28:	ec06                	sd	ra,24(sp)
     f2a:	e822                	sd	s0,16(sp)
     f2c:	e426                	sd	s1,8(sp)
     f2e:	1000                	addi	s0,sp,32
     f30:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
     f32:	00351693          	slli	a3,a0,0x3
     f36:	00000797          	auipc	a5,0x0
     f3a:	76a78793          	addi	a5,a5,1898 # 16a0 <putc_buf>
     f3e:	97b6                	add	a5,a5,a3
     f40:	6388                	ld	a0,0(a5)
  if(buf) {
     f42:	c511                	beqz	a0,f4e <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
     f44:	60e2                	ld	ra,24(sp)
     f46:	6442                	ld	s0,16(sp)
     f48:	64a2                	ld	s1,8(sp)
     f4a:	6105                	addi	sp,sp,32
     f4c:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
     f4e:	6505                	lui	a0,0x1
     f50:	00000097          	auipc	ra,0x0
     f54:	464080e7          	jalr	1124(ra) # 13b4 <malloc>
  putc_buf[fd] = buf;
     f58:	00000797          	auipc	a5,0x0
     f5c:	74878793          	addi	a5,a5,1864 # 16a0 <putc_buf>
     f60:	00349713          	slli	a4,s1,0x3
     f64:	973e                	add	a4,a4,a5
     f66:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
     f68:	00249713          	slli	a4,s1,0x2
     f6c:	973e                	add	a4,a4,a5
     f6e:	32072023          	sw	zero,800(a4)
  return buf;
     f72:	bfc9                	j	f44 <get_putc_buf+0x1e>

0000000000000f74 <putc>:

static void
putc(int fd, char c)
{
     f74:	1101                	addi	sp,sp,-32
     f76:	ec06                	sd	ra,24(sp)
     f78:	e822                	sd	s0,16(sp)
     f7a:	e426                	sd	s1,8(sp)
     f7c:	e04a                	sd	s2,0(sp)
     f7e:	1000                	addi	s0,sp,32
     f80:	84aa                	mv	s1,a0
     f82:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
     f84:	00000097          	auipc	ra,0x0
     f88:	fa2080e7          	jalr	-94(ra) # f26 <get_putc_buf>
  buf[putc_index[fd]++] = c;
     f8c:	00249793          	slli	a5,s1,0x2
     f90:	00000717          	auipc	a4,0x0
     f94:	71070713          	addi	a4,a4,1808 # 16a0 <putc_buf>
     f98:	973e                	add	a4,a4,a5
     f9a:	32072783          	lw	a5,800(a4)
     f9e:	0017869b          	addiw	a3,a5,1
     fa2:	32d72023          	sw	a3,800(a4)
     fa6:	97aa                	add	a5,a5,a0
     fa8:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
     fac:	47a9                	li	a5,10
     fae:	02f90463          	beq	s2,a5,fd6 <putc+0x62>
     fb2:	00249713          	slli	a4,s1,0x2
     fb6:	00000797          	auipc	a5,0x0
     fba:	6ea78793          	addi	a5,a5,1770 # 16a0 <putc_buf>
     fbe:	97ba                	add	a5,a5,a4
     fc0:	3207a703          	lw	a4,800(a5)
     fc4:	6785                	lui	a5,0x1
     fc6:	00f70863          	beq	a4,a5,fd6 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
     fca:	60e2                	ld	ra,24(sp)
     fcc:	6442                	ld	s0,16(sp)
     fce:	64a2                	ld	s1,8(sp)
     fd0:	6902                	ld	s2,0(sp)
     fd2:	6105                	addi	sp,sp,32
     fd4:	8082                	ret
    write(fd, buf, putc_index[fd]);
     fd6:	00249793          	slli	a5,s1,0x2
     fda:	00000917          	auipc	s2,0x0
     fde:	6c690913          	addi	s2,s2,1734 # 16a0 <putc_buf>
     fe2:	993e                	add	s2,s2,a5
     fe4:	32092603          	lw	a2,800(s2)
     fe8:	85aa                	mv	a1,a0
     fea:	8526                	mv	a0,s1
     fec:	00000097          	auipc	ra,0x0
     ff0:	e92080e7          	jalr	-366(ra) # e7e <write>
    putc_index[fd] = 0;
     ff4:	32092023          	sw	zero,800(s2)
}
     ff8:	bfc9                	j	fca <putc+0x56>

0000000000000ffa <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ffa:	7139                	addi	sp,sp,-64
     ffc:	fc06                	sd	ra,56(sp)
     ffe:	f822                	sd	s0,48(sp)
    1000:	f426                	sd	s1,40(sp)
    1002:	f04a                	sd	s2,32(sp)
    1004:	ec4e                	sd	s3,24(sp)
    1006:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1008:	c299                	beqz	a3,100e <printint+0x14>
    100a:	0005cd63          	bltz	a1,1024 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    100e:	2581                	sext.w	a1,a1
  neg = 0;
    1010:	4301                	li	t1,0
    1012:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
    1016:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
    1018:	2601                	sext.w	a2,a2
    101a:	00000897          	auipc	a7,0x0
    101e:	5e688893          	addi	a7,a7,1510 # 1600 <digits>
    1022:	a801                	j	1032 <printint+0x38>
    x = -xx;
    1024:	40b005bb          	negw	a1,a1
    1028:	2581                	sext.w	a1,a1
    neg = 1;
    102a:	4305                	li	t1,1
    x = -xx;
    102c:	b7dd                	j	1012 <printint+0x18>
  }while((x /= base) != 0);
    102e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
    1030:	8836                	mv	a6,a3
    1032:	0018069b          	addiw	a3,a6,1
    1036:	02c5f7bb          	remuw	a5,a1,a2
    103a:	1782                	slli	a5,a5,0x20
    103c:	9381                	srli	a5,a5,0x20
    103e:	97c6                	add	a5,a5,a7
    1040:	0007c783          	lbu	a5,0(a5) # 1000 <printint+0x6>
    1044:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
    1048:	0705                	addi	a4,a4,1
    104a:	02c5d7bb          	divuw	a5,a1,a2
    104e:	fec5f0e3          	bleu	a2,a1,102e <printint+0x34>
  if(neg)
    1052:	00030b63          	beqz	t1,1068 <printint+0x6e>
    buf[i++] = '-';
    1056:	fd040793          	addi	a5,s0,-48
    105a:	96be                	add	a3,a3,a5
    105c:	02d00793          	li	a5,45
    1060:	fef68823          	sb	a5,-16(a3)
    1064:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
    1068:	02d05963          	blez	a3,109a <printint+0xa0>
    106c:	89aa                	mv	s3,a0
    106e:	fc040793          	addi	a5,s0,-64
    1072:	00d784b3          	add	s1,a5,a3
    1076:	fff78913          	addi	s2,a5,-1
    107a:	9936                	add	s2,s2,a3
    107c:	36fd                	addiw	a3,a3,-1
    107e:	1682                	slli	a3,a3,0x20
    1080:	9281                	srli	a3,a3,0x20
    1082:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
    1086:	fff4c583          	lbu	a1,-1(s1)
    108a:	854e                	mv	a0,s3
    108c:	00000097          	auipc	ra,0x0
    1090:	ee8080e7          	jalr	-280(ra) # f74 <putc>
  while(--i >= 0)
    1094:	14fd                	addi	s1,s1,-1
    1096:	ff2498e3          	bne	s1,s2,1086 <printint+0x8c>
}
    109a:	70e2                	ld	ra,56(sp)
    109c:	7442                	ld	s0,48(sp)
    109e:	74a2                	ld	s1,40(sp)
    10a0:	7902                	ld	s2,32(sp)
    10a2:	69e2                	ld	s3,24(sp)
    10a4:	6121                	addi	sp,sp,64
    10a6:	8082                	ret

00000000000010a8 <fflush>:
void fflush(int fd){
    10a8:	1101                	addi	sp,sp,-32
    10aa:	ec06                	sd	ra,24(sp)
    10ac:	e822                	sd	s0,16(sp)
    10ae:	e426                	sd	s1,8(sp)
    10b0:	e04a                	sd	s2,0(sp)
    10b2:	1000                	addi	s0,sp,32
    10b4:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
    10b6:	00000097          	auipc	ra,0x0
    10ba:	e70080e7          	jalr	-400(ra) # f26 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
    10be:	00291793          	slli	a5,s2,0x2
    10c2:	00000497          	auipc	s1,0x0
    10c6:	5de48493          	addi	s1,s1,1502 # 16a0 <putc_buf>
    10ca:	94be                	add	s1,s1,a5
    10cc:	3204a603          	lw	a2,800(s1)
    10d0:	85aa                	mv	a1,a0
    10d2:	854a                	mv	a0,s2
    10d4:	00000097          	auipc	ra,0x0
    10d8:	daa080e7          	jalr	-598(ra) # e7e <write>
  putc_index[fd] = 0;
    10dc:	3204a023          	sw	zero,800(s1)
}
    10e0:	60e2                	ld	ra,24(sp)
    10e2:	6442                	ld	s0,16(sp)
    10e4:	64a2                	ld	s1,8(sp)
    10e6:	6902                	ld	s2,0(sp)
    10e8:	6105                	addi	sp,sp,32
    10ea:	8082                	ret

00000000000010ec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    10ec:	7119                	addi	sp,sp,-128
    10ee:	fc86                	sd	ra,120(sp)
    10f0:	f8a2                	sd	s0,112(sp)
    10f2:	f4a6                	sd	s1,104(sp)
    10f4:	f0ca                	sd	s2,96(sp)
    10f6:	ecce                	sd	s3,88(sp)
    10f8:	e8d2                	sd	s4,80(sp)
    10fa:	e4d6                	sd	s5,72(sp)
    10fc:	e0da                	sd	s6,64(sp)
    10fe:	fc5e                	sd	s7,56(sp)
    1100:	f862                	sd	s8,48(sp)
    1102:	f466                	sd	s9,40(sp)
    1104:	f06a                	sd	s10,32(sp)
    1106:	ec6e                	sd	s11,24(sp)
    1108:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    110a:	0005c483          	lbu	s1,0(a1)
    110e:	18048d63          	beqz	s1,12a8 <vprintf+0x1bc>
    1112:	8aaa                	mv	s5,a0
    1114:	8b32                	mv	s6,a2
    1116:	00158913          	addi	s2,a1,1
  state = 0;
    111a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    111c:	02500a13          	li	s4,37
      if(c == 'd'){
    1120:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    1124:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    1128:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    112c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1130:	00000b97          	auipc	s7,0x0
    1134:	4d0b8b93          	addi	s7,s7,1232 # 1600 <digits>
    1138:	a839                	j	1156 <vprintf+0x6a>
        putc(fd, c);
    113a:	85a6                	mv	a1,s1
    113c:	8556                	mv	a0,s5
    113e:	00000097          	auipc	ra,0x0
    1142:	e36080e7          	jalr	-458(ra) # f74 <putc>
    1146:	a019                	j	114c <vprintf+0x60>
    } else if(state == '%'){
    1148:	01498f63          	beq	s3,s4,1166 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    114c:	0905                	addi	s2,s2,1
    114e:	fff94483          	lbu	s1,-1(s2)
    1152:	14048b63          	beqz	s1,12a8 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
    1156:	0004879b          	sext.w	a5,s1
    if(state == 0){
    115a:	fe0997e3          	bnez	s3,1148 <vprintf+0x5c>
      if(c == '%'){
    115e:	fd479ee3          	bne	a5,s4,113a <vprintf+0x4e>
        state = '%';
    1162:	89be                	mv	s3,a5
    1164:	b7e5                	j	114c <vprintf+0x60>
      if(c == 'd'){
    1166:	05878063          	beq	a5,s8,11a6 <vprintf+0xba>
      } else if(c == 'l') {
    116a:	05978c63          	beq	a5,s9,11c2 <vprintf+0xd6>
      } else if(c == 'x') {
    116e:	07a78863          	beq	a5,s10,11de <vprintf+0xf2>
      } else if(c == 'p') {
    1172:	09b78463          	beq	a5,s11,11fa <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    1176:	07300713          	li	a4,115
    117a:	0ce78563          	beq	a5,a4,1244 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    117e:	06300713          	li	a4,99
    1182:	0ee78c63          	beq	a5,a4,127a <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1186:	11478663          	beq	a5,s4,1292 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    118a:	85d2                	mv	a1,s4
    118c:	8556                	mv	a0,s5
    118e:	00000097          	auipc	ra,0x0
    1192:	de6080e7          	jalr	-538(ra) # f74 <putc>
        putc(fd, c);
    1196:	85a6                	mv	a1,s1
    1198:	8556                	mv	a0,s5
    119a:	00000097          	auipc	ra,0x0
    119e:	dda080e7          	jalr	-550(ra) # f74 <putc>
      }
      state = 0;
    11a2:	4981                	li	s3,0
    11a4:	b765                	j	114c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    11a6:	008b0493          	addi	s1,s6,8
    11aa:	4685                	li	a3,1
    11ac:	4629                	li	a2,10
    11ae:	000b2583          	lw	a1,0(s6)
    11b2:	8556                	mv	a0,s5
    11b4:	00000097          	auipc	ra,0x0
    11b8:	e46080e7          	jalr	-442(ra) # ffa <printint>
    11bc:	8b26                	mv	s6,s1
      state = 0;
    11be:	4981                	li	s3,0
    11c0:	b771                	j	114c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    11c2:	008b0493          	addi	s1,s6,8
    11c6:	4681                	li	a3,0
    11c8:	4629                	li	a2,10
    11ca:	000b2583          	lw	a1,0(s6)
    11ce:	8556                	mv	a0,s5
    11d0:	00000097          	auipc	ra,0x0
    11d4:	e2a080e7          	jalr	-470(ra) # ffa <printint>
    11d8:	8b26                	mv	s6,s1
      state = 0;
    11da:	4981                	li	s3,0
    11dc:	bf85                	j	114c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    11de:	008b0493          	addi	s1,s6,8
    11e2:	4681                	li	a3,0
    11e4:	4641                	li	a2,16
    11e6:	000b2583          	lw	a1,0(s6)
    11ea:	8556                	mv	a0,s5
    11ec:	00000097          	auipc	ra,0x0
    11f0:	e0e080e7          	jalr	-498(ra) # ffa <printint>
    11f4:	8b26                	mv	s6,s1
      state = 0;
    11f6:	4981                	li	s3,0
    11f8:	bf91                	j	114c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    11fa:	008b0793          	addi	a5,s6,8
    11fe:	f8f43423          	sd	a5,-120(s0)
    1202:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    1206:	03000593          	li	a1,48
    120a:	8556                	mv	a0,s5
    120c:	00000097          	auipc	ra,0x0
    1210:	d68080e7          	jalr	-664(ra) # f74 <putc>
  putc(fd, 'x');
    1214:	85ea                	mv	a1,s10
    1216:	8556                	mv	a0,s5
    1218:	00000097          	auipc	ra,0x0
    121c:	d5c080e7          	jalr	-676(ra) # f74 <putc>
    1220:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1222:	03c9d793          	srli	a5,s3,0x3c
    1226:	97de                	add	a5,a5,s7
    1228:	0007c583          	lbu	a1,0(a5)
    122c:	8556                	mv	a0,s5
    122e:	00000097          	auipc	ra,0x0
    1232:	d46080e7          	jalr	-698(ra) # f74 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1236:	0992                	slli	s3,s3,0x4
    1238:	34fd                	addiw	s1,s1,-1
    123a:	f4e5                	bnez	s1,1222 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    123c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    1240:	4981                	li	s3,0
    1242:	b729                	j	114c <vprintf+0x60>
        s = va_arg(ap, char*);
    1244:	008b0993          	addi	s3,s6,8
    1248:	000b3483          	ld	s1,0(s6)
        if(s == 0)
    124c:	c085                	beqz	s1,126c <vprintf+0x180>
        while(*s != 0){
    124e:	0004c583          	lbu	a1,0(s1)
    1252:	c9a1                	beqz	a1,12a2 <vprintf+0x1b6>
          putc(fd, *s);
    1254:	8556                	mv	a0,s5
    1256:	00000097          	auipc	ra,0x0
    125a:	d1e080e7          	jalr	-738(ra) # f74 <putc>
          s++;
    125e:	0485                	addi	s1,s1,1
        while(*s != 0){
    1260:	0004c583          	lbu	a1,0(s1)
    1264:	f9e5                	bnez	a1,1254 <vprintf+0x168>
        s = va_arg(ap, char*);
    1266:	8b4e                	mv	s6,s3
      state = 0;
    1268:	4981                	li	s3,0
    126a:	b5cd                	j	114c <vprintf+0x60>
          s = "(null)";
    126c:	00000497          	auipc	s1,0x0
    1270:	3ac48493          	addi	s1,s1,940 # 1618 <digits+0x18>
        while(*s != 0){
    1274:	02800593          	li	a1,40
    1278:	bff1                	j	1254 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
    127a:	008b0493          	addi	s1,s6,8
    127e:	000b4583          	lbu	a1,0(s6)
    1282:	8556                	mv	a0,s5
    1284:	00000097          	auipc	ra,0x0
    1288:	cf0080e7          	jalr	-784(ra) # f74 <putc>
    128c:	8b26                	mv	s6,s1
      state = 0;
    128e:	4981                	li	s3,0
    1290:	bd75                	j	114c <vprintf+0x60>
        putc(fd, c);
    1292:	85d2                	mv	a1,s4
    1294:	8556                	mv	a0,s5
    1296:	00000097          	auipc	ra,0x0
    129a:	cde080e7          	jalr	-802(ra) # f74 <putc>
      state = 0;
    129e:	4981                	li	s3,0
    12a0:	b575                	j	114c <vprintf+0x60>
        s = va_arg(ap, char*);
    12a2:	8b4e                	mv	s6,s3
      state = 0;
    12a4:	4981                	li	s3,0
    12a6:	b55d                	j	114c <vprintf+0x60>
    }
  }
}
    12a8:	70e6                	ld	ra,120(sp)
    12aa:	7446                	ld	s0,112(sp)
    12ac:	74a6                	ld	s1,104(sp)
    12ae:	7906                	ld	s2,96(sp)
    12b0:	69e6                	ld	s3,88(sp)
    12b2:	6a46                	ld	s4,80(sp)
    12b4:	6aa6                	ld	s5,72(sp)
    12b6:	6b06                	ld	s6,64(sp)
    12b8:	7be2                	ld	s7,56(sp)
    12ba:	7c42                	ld	s8,48(sp)
    12bc:	7ca2                	ld	s9,40(sp)
    12be:	7d02                	ld	s10,32(sp)
    12c0:	6de2                	ld	s11,24(sp)
    12c2:	6109                	addi	sp,sp,128
    12c4:	8082                	ret

00000000000012c6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    12c6:	715d                	addi	sp,sp,-80
    12c8:	ec06                	sd	ra,24(sp)
    12ca:	e822                	sd	s0,16(sp)
    12cc:	1000                	addi	s0,sp,32
    12ce:	e010                	sd	a2,0(s0)
    12d0:	e414                	sd	a3,8(s0)
    12d2:	e818                	sd	a4,16(s0)
    12d4:	ec1c                	sd	a5,24(s0)
    12d6:	03043023          	sd	a6,32(s0)
    12da:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    12de:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    12e2:	8622                	mv	a2,s0
    12e4:	00000097          	auipc	ra,0x0
    12e8:	e08080e7          	jalr	-504(ra) # 10ec <vprintf>
}
    12ec:	60e2                	ld	ra,24(sp)
    12ee:	6442                	ld	s0,16(sp)
    12f0:	6161                	addi	sp,sp,80
    12f2:	8082                	ret

00000000000012f4 <printf>:

void
printf(const char *fmt, ...)
{
    12f4:	711d                	addi	sp,sp,-96
    12f6:	ec06                	sd	ra,24(sp)
    12f8:	e822                	sd	s0,16(sp)
    12fa:	1000                	addi	s0,sp,32
    12fc:	e40c                	sd	a1,8(s0)
    12fe:	e810                	sd	a2,16(s0)
    1300:	ec14                	sd	a3,24(s0)
    1302:	f018                	sd	a4,32(s0)
    1304:	f41c                	sd	a5,40(s0)
    1306:	03043823          	sd	a6,48(s0)
    130a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    130e:	00840613          	addi	a2,s0,8
    1312:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1316:	85aa                	mv	a1,a0
    1318:	4505                	li	a0,1
    131a:	00000097          	auipc	ra,0x0
    131e:	dd2080e7          	jalr	-558(ra) # 10ec <vprintf>
}
    1322:	60e2                	ld	ra,24(sp)
    1324:	6442                	ld	s0,16(sp)
    1326:	6125                	addi	sp,sp,96
    1328:	8082                	ret

000000000000132a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    132a:	1141                	addi	sp,sp,-16
    132c:	e422                	sd	s0,8(sp)
    132e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1330:	ff050693          	addi	a3,a0,-16 # ff0 <putc+0x7c>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1334:	00000797          	auipc	a5,0x0
    1338:	2fc78793          	addi	a5,a5,764 # 1630 <freep>
    133c:	639c                	ld	a5,0(a5)
    133e:	a805                	j	136e <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1340:	4618                	lw	a4,8(a2)
    1342:	9db9                	addw	a1,a1,a4
    1344:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1348:	6398                	ld	a4,0(a5)
    134a:	6318                	ld	a4,0(a4)
    134c:	fee53823          	sd	a4,-16(a0)
    1350:	a091                	j	1394 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1352:	ff852703          	lw	a4,-8(a0)
    1356:	9e39                	addw	a2,a2,a4
    1358:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    135a:	ff053703          	ld	a4,-16(a0)
    135e:	e398                	sd	a4,0(a5)
    1360:	a099                	j	13a6 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1362:	6398                	ld	a4,0(a5)
    1364:	00e7e463          	bltu	a5,a4,136c <free+0x42>
    1368:	00e6ea63          	bltu	a3,a4,137c <free+0x52>
{
    136c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    136e:	fed7fae3          	bleu	a3,a5,1362 <free+0x38>
    1372:	6398                	ld	a4,0(a5)
    1374:	00e6e463          	bltu	a3,a4,137c <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1378:	fee7eae3          	bltu	a5,a4,136c <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    137c:	ff852583          	lw	a1,-8(a0)
    1380:	6390                	ld	a2,0(a5)
    1382:	02059713          	slli	a4,a1,0x20
    1386:	9301                	srli	a4,a4,0x20
    1388:	0712                	slli	a4,a4,0x4
    138a:	9736                	add	a4,a4,a3
    138c:	fae60ae3          	beq	a2,a4,1340 <free+0x16>
    bp->s.ptr = p->s.ptr;
    1390:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1394:	4790                	lw	a2,8(a5)
    1396:	02061713          	slli	a4,a2,0x20
    139a:	9301                	srli	a4,a4,0x20
    139c:	0712                	slli	a4,a4,0x4
    139e:	973e                	add	a4,a4,a5
    13a0:	fae689e3          	beq	a3,a4,1352 <free+0x28>
  } else
    p->s.ptr = bp;
    13a4:	e394                	sd	a3,0(a5)
  freep = p;
    13a6:	00000717          	auipc	a4,0x0
    13aa:	28f73523          	sd	a5,650(a4) # 1630 <freep>
}
    13ae:	6422                	ld	s0,8(sp)
    13b0:	0141                	addi	sp,sp,16
    13b2:	8082                	ret

00000000000013b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    13b4:	7139                	addi	sp,sp,-64
    13b6:	fc06                	sd	ra,56(sp)
    13b8:	f822                	sd	s0,48(sp)
    13ba:	f426                	sd	s1,40(sp)
    13bc:	f04a                	sd	s2,32(sp)
    13be:	ec4e                	sd	s3,24(sp)
    13c0:	e852                	sd	s4,16(sp)
    13c2:	e456                	sd	s5,8(sp)
    13c4:	e05a                	sd	s6,0(sp)
    13c6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13c8:	02051993          	slli	s3,a0,0x20
    13cc:	0209d993          	srli	s3,s3,0x20
    13d0:	09bd                	addi	s3,s3,15
    13d2:	0049d993          	srli	s3,s3,0x4
    13d6:	2985                	addiw	s3,s3,1
    13d8:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
    13dc:	00000797          	auipc	a5,0x0
    13e0:	25478793          	addi	a5,a5,596 # 1630 <freep>
    13e4:	6388                	ld	a0,0(a5)
    13e6:	c515                	beqz	a0,1412 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13ea:	4798                	lw	a4,8(a5)
    13ec:	03277f63          	bleu	s2,a4,142a <malloc+0x76>
    13f0:	8a4e                	mv	s4,s3
    13f2:	0009871b          	sext.w	a4,s3
    13f6:	6685                	lui	a3,0x1
    13f8:	00d77363          	bleu	a3,a4,13fe <malloc+0x4a>
    13fc:	6a05                	lui	s4,0x1
    13fe:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
    1402:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1406:	00000497          	auipc	s1,0x0
    140a:	22a48493          	addi	s1,s1,554 # 1630 <freep>
  if(p == (char*)-1)
    140e:	5b7d                	li	s6,-1
    1410:	a885                	j	1480 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    1412:	00000797          	auipc	a5,0x0
    1416:	73e78793          	addi	a5,a5,1854 # 1b50 <base>
    141a:	00000717          	auipc	a4,0x0
    141e:	20f73b23          	sd	a5,534(a4) # 1630 <freep>
    1422:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1424:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1428:	b7e1                	j	13f0 <malloc+0x3c>
      if(p->s.size == nunits)
    142a:	02e90b63          	beq	s2,a4,1460 <malloc+0xac>
        p->s.size -= nunits;
    142e:	4137073b          	subw	a4,a4,s3
    1432:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1434:	1702                	slli	a4,a4,0x20
    1436:	9301                	srli	a4,a4,0x20
    1438:	0712                	slli	a4,a4,0x4
    143a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    143c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1440:	00000717          	auipc	a4,0x0
    1444:	1ea73823          	sd	a0,496(a4) # 1630 <freep>
      return (void*)(p + 1);
    1448:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    144c:	70e2                	ld	ra,56(sp)
    144e:	7442                	ld	s0,48(sp)
    1450:	74a2                	ld	s1,40(sp)
    1452:	7902                	ld	s2,32(sp)
    1454:	69e2                	ld	s3,24(sp)
    1456:	6a42                	ld	s4,16(sp)
    1458:	6aa2                	ld	s5,8(sp)
    145a:	6b02                	ld	s6,0(sp)
    145c:	6121                	addi	sp,sp,64
    145e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1460:	6398                	ld	a4,0(a5)
    1462:	e118                	sd	a4,0(a0)
    1464:	bff1                	j	1440 <malloc+0x8c>
  hp->s.size = nu;
    1466:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
    146a:	0541                	addi	a0,a0,16
    146c:	00000097          	auipc	ra,0x0
    1470:	ebe080e7          	jalr	-322(ra) # 132a <free>
  return freep;
    1474:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    1476:	d979                	beqz	a0,144c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1478:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    147a:	4798                	lw	a4,8(a5)
    147c:	fb2777e3          	bleu	s2,a4,142a <malloc+0x76>
    if(p == freep)
    1480:	6098                	ld	a4,0(s1)
    1482:	853e                	mv	a0,a5
    1484:	fef71ae3          	bne	a4,a5,1478 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    1488:	8552                	mv	a0,s4
    148a:	00000097          	auipc	ra,0x0
    148e:	a5c080e7          	jalr	-1444(ra) # ee6 <sbrk>
  if(p == (char*)-1)
    1492:	fd651ae3          	bne	a0,s6,1466 <malloc+0xb2>
        return 0;
    1496:	4501                	li	a0,0
    1498:	bf55                	j	144c <malloc+0x98>
