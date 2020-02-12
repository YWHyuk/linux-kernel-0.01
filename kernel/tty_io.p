# 1 "tty_io.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "tty_io.c"





# 1 "../include/ctype.h" 1
# 13 "../include/ctype.h"
extern unsigned char _ctype[];
extern char _ctmp;
# 7 "tty_io.c" 2
# 1 "../include/errno.h" 1
# 17 "../include/errno.h"
extern int errno;
# 8 "tty_io.c" 2
# 1 "../include/signal.h" 1



# 1 "../include/sys/types.h" 1





typedef unsigned int size_t;




typedef long time_t;




typedef long ptrdiff_t;






typedef int pid_t;
typedef unsigned short uid_t;
typedef unsigned char gid_t;
typedef unsigned short dev_t;
typedef unsigned short ino_t;
typedef unsigned short mode_t;
typedef unsigned short umode_t;
typedef unsigned char nlink_t;
typedef int daddr_t;
typedef long off_t;
typedef unsigned char u_char;
typedef unsigned short ushort;

typedef struct { int quot,rem; } div_t;
typedef struct { long quot,rem; } ldiv_t;

struct ustat {
 daddr_t f_tfree;
 ino_t f_tinode;
 char f_fname[6];
 char f_fpack[6];
};
# 5 "../include/signal.h" 2

typedef int sig_atomic_t;
typedef unsigned int sigset_t;
# 46 "../include/signal.h"
struct sigaction {
 void (*sa_handler)(int);
 sigset_t sa_mask;
 int sa_flags;
};

void (*signal(int _sig, void (*_func)(int)))(int);
int raise(int sig);
int kill(pid_t pid, int sig);
int sigaddset(sigset_t *mask, int signo);
int sigdelset(sigset_t *mask, int signo);
int sigemptyset(sigset_t *mask);
int sigfillset(sigset_t *mask);
int sigismember(sigset_t *mask, int signo);
int sigpending(sigset_t *set);
int sigprocmask(int how, sigset_t *set, sigset_t *oldset);
int sigsuspend(sigset_t *sigmask);
int sigaction(int sig, struct sigaction *act, struct sigaction *oldact);
# 9 "tty_io.c" 2



# 1 "../include/linux/sched.h" 1
# 10 "../include/linux/sched.h"
# 1 "../include/linux/head.h" 1



typedef struct desc_struct {
 unsigned long a,b;
} desc_table[256];

extern unsigned long pg_dir[1024];
extern desc_table idt,gdt;
# 11 "../include/linux/sched.h" 2
# 1 "../include/linux/fs.h" 1
# 29 "../include/linux/fs.h"
void buffer_init(void);
# 54 "../include/linux/fs.h"
typedef char buffer_block[1024];

struct buffer_head {
 char * b_data;
 unsigned short b_dev;
 unsigned short b_blocknr;
 unsigned char b_uptodate;
 unsigned char b_dirt;
 unsigned char b_count;
 unsigned char b_lock;
 struct task_struct * b_wait;
 struct buffer_head * b_prev;
 struct buffer_head * b_next;
 struct buffer_head * b_prev_free;
 struct buffer_head * b_next_free;
};

struct d_inode {
 unsigned short i_mode;
 unsigned short i_uid;
 unsigned long i_size;
 unsigned long i_time;
 unsigned char i_gid;
 unsigned char i_nlinks;
 unsigned short i_zone[9];
};

struct m_inode {
 unsigned short i_mode;
 unsigned short i_uid;
 unsigned long i_size;
 unsigned long i_mtime;
 unsigned char i_gid;
 unsigned char i_nlinks;
 unsigned short i_zone[9];

 struct task_struct * i_wait;
 unsigned long i_atime;
 unsigned long i_ctime;
 unsigned short i_dev;
 unsigned short i_num;
 unsigned short i_count;
 unsigned char i_lock;
 unsigned char i_dirt;
 unsigned char i_pipe;
 unsigned char i_mount;
 unsigned char i_seek;
 unsigned char i_update;
};
# 112 "../include/linux/fs.h"
struct file {
 unsigned short f_mode;
 unsigned short f_flags;
 unsigned short f_count;
 struct m_inode * f_inode;
 off_t f_pos;
};

struct super_block {
 unsigned short s_ninodes;
 unsigned short s_nzones;
 unsigned short s_imap_blocks;
 unsigned short s_zmap_blocks;
 unsigned short s_firstdatazone;
 unsigned short s_log_zone_size;
 unsigned long s_max_size;
 unsigned short s_magic;

 struct buffer_head * s_imap[8];
 struct buffer_head * s_zmap[8];
 unsigned short s_dev;
 struct m_inode * s_isup;
 struct m_inode * s_imount;
 unsigned long s_time;
 unsigned char s_rd_only;
 unsigned char s_dirt;
};

struct dir_entry {
 unsigned short inode;
 char name[14];
};

extern struct m_inode inode_table[32];
extern struct file file_table[64];
extern struct super_block super_block[8];
extern struct buffer_head * start_buffer;
extern int nr_buffers;

extern void truncate(struct m_inode * inode);
extern void sync_inodes(void);
extern void wait_on(struct m_inode * inode);
extern int bmap(struct m_inode * inode,int block);
extern int create_block(struct m_inode * inode,int block);
extern struct m_inode * namei(const char * pathname);
extern int open_namei(const char * pathname, int flag, int mode,
 struct m_inode ** res_inode);
extern void iput(struct m_inode * inode);
extern struct m_inode * iget(int dev,int nr);
extern struct m_inode * get_empty_inode(void);
extern struct m_inode * get_pipe_inode(void);
extern struct buffer_head * get_hash_table(int dev, int block);
extern struct buffer_head * getblk(int dev, int block);
extern void ll_rw_block(int rw, struct buffer_head * bh);
extern void brelse(struct buffer_head * buf);
extern struct buffer_head * bread(int dev,int block);
extern int new_block(int dev);
extern void free_block(int dev, int block);
extern struct m_inode * new_inode(int dev);
extern void free_inode(struct m_inode * inode);

extern void mount_root(void);

extern inline struct super_block * get_super(int dev)
{
 struct super_block * s;

 for(s = 0+super_block;s < 8 +super_block; s++)
  if (s->s_dev == dev)
   return s;
 return ((void *) 0);
}
# 12 "../include/linux/sched.h" 2
# 1 "../include/linux/mm.h" 1





extern unsigned long get_free_page(void);
extern unsigned long put_page(unsigned long page,unsigned long address);
extern void free_page(unsigned long addr);
# 13 "../include/linux/sched.h" 2
# 28 "../include/linux/sched.h"
extern int copy_page_tables(unsigned long from, unsigned long to, long size);
extern int free_page_tables(unsigned long from, long size);

extern void sched_init(void);
extern void schedule(void);
extern void trap_init(void);
extern void panic(const char * str);
extern int tty_write(unsigned minor,char * buf,int count);

typedef int (*fn_ptr)();

struct i387_struct {
 long cwd;
 long swd;
 long twd;
 long fip;
 long fcs;
 long foo;
 long fos;
 long st_space[20];
};

struct tss_struct {
 long back_link;
 long esp0;
 long ss0;
 long esp1;
 long ss1;
 long esp2;
 long ss2;
 long cr3;
 long eip;
 long eflags;
 long eax,ecx,edx,ebx;
 long esp;
 long ebp;
 long esi;
 long edi;
 long es;
 long cs;
 long ss;
 long ds;
 long fs;
 long gs;
 long ldt;
 long trace_bitmap;
 struct i387_struct i387;
};

struct task_struct {

 long state;
 long counter;
 long priority;
 long signal;
 fn_ptr sig_restorer;
 fn_ptr sig_fn[32];

 int exit_code;
 unsigned long end_code,end_data,brk,start_stack;
 long pid,father,pgrp,session,leader;
 unsigned short uid,euid,suid;
 unsigned short gid,egid,sgid;
 long alarm;
 long utime,stime,cutime,cstime,start_time;
 unsigned short used_math;

 int tty;
 unsigned short umask;
 struct m_inode * pwd;
 struct m_inode * root;
 unsigned long close_on_exec;
 struct file * filp[20];

 struct desc_struct ldt[3];

 struct tss_struct tss;
};
# 134 "../include/linux/sched.h"
extern struct task_struct *task[64];
extern struct task_struct *last_task_used_math;
extern struct task_struct *current;
extern long volatile jiffies;
extern long startup_time;



extern void sleep_on(struct task_struct ** p);
extern void interruptible_sleep_on(struct task_struct ** p);
extern void wake_up(struct task_struct ** p);
# 13 "tty_io.c" 2
# 1 "../include/linux/tty.h" 1
# 12 "../include/linux/tty.h"
# 1 "../include/termios.h" 1
# 35 "../include/termios.h"
struct winsize {
 unsigned short ws_row;
 unsigned short ws_col;
 unsigned short ws_xpixel;
 unsigned short ws_ypixel;
};


struct termio {
 unsigned short c_iflag;
 unsigned short c_oflag;
 unsigned short c_cflag;
 unsigned short c_lflag;
 unsigned char c_line;
 unsigned char c_cc[8];
};


struct termios {
 unsigned long c_iflag;
 unsigned long c_oflag;
 unsigned long c_cflag;
 unsigned long c_lflag;
 unsigned char c_line;
 unsigned char c_cc[17];
};
# 208 "../include/termios.h"
typedef int speed_t;

extern speed_t cfgetispeed(struct termios *termios_p);
extern speed_t cfgetospeed(struct termios *termios_p);
extern int cfsetispeed(struct termios *termios_p, speed_t speed);
extern int cfsetospeed(struct termios *termios_p, speed_t speed);
extern int tcdrain(int fildes);
extern int tcflow(int fildes, int action);
extern int tcflush(int fildes, int queue_selector);
extern int tcgetattr(int fildes, struct termios *termios_p);
extern int tcsendbreak(int fildes, int duration);
extern int tcsetattr(int fildes, int optional_actions,
 struct termios *termios_p);
# 13 "../include/linux/tty.h" 2



struct tty_queue {
 unsigned long data;
 unsigned long head;
 unsigned long tail;
 struct task_struct * proc_list;
 char buf[1024];
};
# 42 "../include/linux/tty.h"
struct tty_struct {
 struct termios termios;
 int pgrp;
 int stopped;
 void (*write)(struct tty_struct * tty);
 struct tty_queue read_q;
 struct tty_queue write_q;
 struct tty_queue secondary;
 };

extern struct tty_struct tty_table[];
# 62 "../include/linux/tty.h"
void rs_init(void);
void con_init(void);
void tty_init(void);

int tty_read(unsigned c, char * buf, int n);
int tty_write(unsigned c, char * buf, int n);

void rs_write(struct tty_struct * tty);
void con_write(struct tty_struct * tty);

void copy_to_cooked(struct tty_struct * tty);
# 14 "tty_io.c" 2
# 1 "../include/asm/segment.h" 1
extern inline unsigned char get_fs_byte(const char * addr)
{
 unsigned register char _v;

 __asm__ ("movb %%fs:%1,%0":"=r" (_v):"m" (*addr));
 return _v;
}

extern inline unsigned short get_fs_word(const unsigned short *addr)
{
 unsigned short _v;

 __asm__ ("movw %%fs:%1,%0":"=r" (_v):"m" (*addr));
 return _v;
}

extern inline unsigned long get_fs_long(const unsigned long *addr)
{
 unsigned long _v;

 __asm__ ("movl %%fs:%1,%0":"=r" (_v):"m" (*addr));
 return _v;
}

extern inline void put_fs_byte(char val,char *addr)
{
__asm__ ("movb %0,%%fs:%1"::"r" (val),"m" (*addr));
}

extern inline void put_fs_word(short val,short * addr)
{
__asm__ ("movw %0,%%fs:%1"::"r" (val),"m" (*addr));
}

extern inline void put_fs_long(unsigned long val,unsigned long * addr)
{
__asm__ ("movl %0,%%fs:%1"::"r" (val),"m" (*addr));
}
# 15 "tty_io.c" 2
# 1 "../include/asm/system.h" 1
# 16 "tty_io.c" 2
# 40 "tty_io.c"
struct tty_struct tty_table[] = {
 {
  {0,
  0000001|0000004,
  0,
  0000002 | 0000010 | 0001000 | 0004000,
  0,
  "\003\034\177\025\004\0\1\0\021\023\031\0\022\017\027\026\0"},
  0,
  0,
  con_write,
  {0,0,0,0,""},
  {0,0,0,0,""},
  {0,0,0,0,""}
 },{
  {0,
  0000001 | 0000040,
  0000013 | 0000060,
  0,
  0,
  "\003\034\177\025\004\0\1\0\021\023\031\0\022\017\027\026\0"},
  0,
  0,
  rs_write,
  {0x3f8,0,0,0,""},
  {0x3f8,0,0,0,""},
  {0,0,0,0,""}
 },{
  {0,
  0000001 | 0000040,
  0000013 | 0000060,
  0,
  0,
  "\003\034\177\025\004\0\1\0\021\023\031\0\022\017\027\026\0"},
  0,
  0,
  rs_write,
  {0x2f8,0,0,0,""},
  {0x2f8,0,0,0,""},
  {0,0,0,0,""}
 }
};






struct tty_queue * table_list[]={
 &tty_table[0].read_q, &tty_table[0].write_q,
 &tty_table[1].read_q, &tty_table[1].write_q,
 &tty_table[2].read_q, &tty_table[2].write_q
 };

void tty_init(void)
{
 rs_init();
 con_init();
}

void tty_intr(struct tty_struct * tty, int signal)
{
 int i;

 if (tty->pgrp <= 0)
  return;
 for (i=0;i<64;i++)
  if (task[i] && task[i]->pgrp==tty->pgrp)
   task[i]->signal |= 1<<(signal-1);
}

static void sleep_if_empty(struct tty_queue * queue)
{
 __asm__ ("cli"::);
 while (!current->signal && ((*queue).head == (*queue).tail))
  interruptible_sleep_on(&queue->proc_list);
 __asm__ ("sti"::);
}

static void sleep_if_full(struct tty_queue * queue)
{
 if (!(!(((*queue).tail-(*queue).head-1)&(1024 -1))))
  return;
 __asm__ ("cli"::);
 while (!current->signal && (((*queue).tail-(*queue).head-1)&(1024 -1))<128)
  interruptible_sleep_on(&queue->proc_list);
 __asm__ ("sti"::);
}

void copy_to_cooked(struct tty_struct * tty)
{
 signed char c;

 while (!((tty->read_q).head == (tty->read_q).tail) && !(!(((tty->secondary).tail-(tty->secondary).head-1)&(1024 -1)))) {
  (void)({c=(tty->read_q).buf[(tty->read_q).tail];(((tty->read_q).tail) = (((tty->read_q).tail)+1) & (1024 -1));});
  if (c==13)
   if ((((tty))->termios.c_iflag & 0000400))
    c=10;
   else if ((((tty))->termios.c_iflag & 0000200))
    continue;
   else ;
  else if (c==10 && (((tty))->termios.c_iflag & 0000100))
   c=13;
  if ((((tty))->termios.c_iflag & 0001000))
   c=(char _ctmp=c; ((_ctype+1)[_ctmp]&(0x01))?_ctmp+('a'+'A'):_ctmp);
  if ((((tty))->termios.c_lflag & 0000002)) {
   if (c==((tty)->termios.c_cc[2])) {
    if (((tty->secondary).head == (tty->secondary).tail) ||
       (c=((tty->secondary).buf[(1024 -1)&((tty->secondary).head-1)]))==10 ||
       c==((tty)->termios.c_cc[4]))
     continue;
    if ((((tty))->termios.c_lflag & 0000010)) {
     if (c<32)
      (void)({(tty->write_q).buf[(tty->write_q).head]=(127);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
     (void)({(tty->write_q).buf[(tty->write_q).head]=(127);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
     tty->write(tty);
    }
    ((tty->secondary.head) = ((tty->secondary.head)-1) & (1024 -1));
    continue;
   }
   if (c==((tty)->termios.c_cc[9])) {
    tty->stopped=1;
    continue;
   }
   if (c==((tty)->termios.c_cc[8])) {
    tty->stopped=0;
    continue;
   }
  }
  if (!(((tty))->termios.c_lflag & 0000001)) {
   if (c==((tty)->termios.c_cc[0])) {
    tty_intr(tty,2);
    continue;
   }
  }
  if (c==10 || c==((tty)->termios.c_cc[4]))
   tty->secondary.data++;
  if ((((tty))->termios.c_lflag & 0000010)) {
   if (c==10) {
    (void)({(tty->write_q).buf[(tty->write_q).head]=(10);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
    (void)({(tty->write_q).buf[(tty->write_q).head]=(13);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
   } else if (c<32) {
    if ((((tty))->termios.c_lflag & 0001000)) {
     (void)({(tty->write_q).buf[(tty->write_q).head]=('^');(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
     (void)({(tty->write_q).buf[(tty->write_q).head]=(c+64);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
    }
   } else
    (void)({(tty->write_q).buf[(tty->write_q).head]=(c);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
   tty->write(tty);
  }
  (void)({(tty->secondary).buf[(tty->secondary).head]=(c);(((tty->secondary).head) = (((tty->secondary).head)+1) & (1024 -1));});
 }
 wake_up(&tty->secondary.proc_list);
}

int tty_read(unsigned channel, char * buf, int nr)
{
 struct tty_struct * tty;
 char c, * b=buf;
 int minimum,time,flag=0;
 long oldalarm;

 if (channel>2 || nr<0) return -1;
 tty = &tty_table[channel];
 oldalarm = current->alarm;
 time = (unsigned) 10*tty->termios.c_cc[5];
 minimum = (unsigned) tty->termios.c_cc[6];
 if (time && !minimum) {
  minimum=1;
  if (flag=(!oldalarm || time+jiffies<oldalarm))
   current->alarm = time+jiffies;
 }
 if (minimum>nr)
  minimum=nr;
 while (nr>0) {
  if (flag && (current->signal & (1<<(14 -1)))) {
   current->signal &= ~(1<<(14 -1));
   break;
  }
  if (current->signal)
   break;
  if (((tty->secondary).head == (tty->secondary).tail) || ((((tty))->termios.c_lflag & 0000002) &&
  !tty->secondary.data && (((tty->secondary).tail-(tty->secondary).head-1)&(1024 -1))>20)) {
   sleep_if_empty(&tty->secondary);
   continue;
  }
  do {
   (void)({c=(tty->secondary).buf[(tty->secondary).tail];(((tty->secondary).tail) = (((tty->secondary).tail)+1) & (1024 -1));});
   if (c==((tty)->termios.c_cc[4]) || c==10)
    tty->secondary.data--;
   if (c==((tty)->termios.c_cc[4]) && (((tty))->termios.c_lflag & 0000002))
    return (b-buf);
   else {
    put_fs_byte(c,b++);
    if (!--nr)
     break;
   }
  } while (nr>0 && !((tty->secondary).head == (tty->secondary).tail));
  if (time && !(((tty))->termios.c_lflag & 0000002))
   if (flag=(!oldalarm || time+jiffies<oldalarm))
    current->alarm = time+jiffies;
   else
    current->alarm = oldalarm;
  if ((((tty))->termios.c_lflag & 0000002)) {
   if (b-buf)
    break;
  } else if (b-buf >= minimum)
   break;
 }
 current->alarm = oldalarm;
 if (current->signal && !(b-buf))
  return -4;
 return (b-buf);
}

int tty_write(unsigned channel, char * buf, int nr)
{
 static int cr_flag=0;
 struct tty_struct * tty;
 char c, *b=buf;

 if (channel>2 || nr<0) return -1;
 tty = channel + tty_table;
 while (nr>0) {
  sleep_if_full(&tty->write_q);
  if (current->signal)
   break;
  while (nr>0 && !(!(((tty->write_q).tail-(tty->write_q).head-1)&(1024 -1)))) {
   c=get_fs_byte(b);
   if ((((tty))->termios.c_oflag & 0000001)) {
    if (c=='\r' && (((tty))->termios.c_oflag & 0000010))
     c='\n';
    else if (c=='\n' && (((tty))->termios.c_oflag & 0000040))
     c='\r';
    if (c=='\n' && !cr_flag && (((tty))->termios.c_oflag & 0000004)) {
     cr_flag = 1;
     (void)({(tty->write_q).buf[(tty->write_q).head]=(13);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
     continue;
    }
    if ((((tty))->termios.c_oflag & 0000002))
     c=(char)(char _ctmp=c; ((_ctype+1)[_ctmp]&(0x02))?_ctmp+('A'-'a'):_ctmp);
   }
   b++; nr--;
   cr_flag = 0;
   (void)({(tty->write_q).buf[(tty->write_q).head]=(c);(((tty->write_q).head) = (((tty->write_q).head)+1) & (1024 -1));});
  }
  tty->write(tty);
  if (nr>0)
   schedule();
 }
 return (b-buf);
}
# 303 "tty_io.c"
void do_tty_interrupt(int tty)
{
 copy_to_cooked(tty_table+tty);
}
