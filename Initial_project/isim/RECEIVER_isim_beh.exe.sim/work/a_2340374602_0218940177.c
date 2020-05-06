/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/Desktop/PUF/Initial_project/receiver.vhd";
extern char *IEEE_P_0017514958;

unsigned char ieee_p_0017514958_sub_2060948036078220983_1861681735(char *, char *, char *);


static void work_a_2340374602_0218940177_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    int t14;
    int t15;
    unsigned char t16;
    int t17;
    int t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;

LAB0:    xsi_set_current_line(40, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1152U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    xsi_set_current_line(104, ng0);
    t1 = (t0 + 3928U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 5752);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(105, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 5688);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 8U);
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 5224);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(41, ng0);
    t1 = (t0 + 5304);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(42, ng0);
    t1 = (t0 + 5368);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(43, ng0);
    t1 = (t0 + 5432);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(44, ng0);
    t1 = (t0 + 3928U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((unsigned char *)t1) = (unsigned char)2;
    xsi_set_current_line(45, ng0);
    t1 = (t0 + 5496);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(46, ng0);
    t1 = (t0 + 5560);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(47, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t5 = (t0 + 5624);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(48, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t5 = (t0 + 5688);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB3;

LAB5:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2152U);
    t6 = *((char **)t2);
    t12 = *((unsigned char *)t6);
    t13 = (t12 == (unsigned char)1);
    if (t13 != 0)
        goto LAB10;

LAB12:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB19;

LAB20:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB30;

LAB31:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)0);
    if (t10 == 1)
        goto LAB43;

LAB44:    t3 = (unsigned char)0;

LAB45:    if (t3 != 0)
        goto LAB41;

LAB42:
LAB11:    goto LAB3;

LAB7:    t2 = (t0 + 1192U);
    t5 = *((char **)t2);
    t10 = *((unsigned char *)t5);
    t11 = (t10 == (unsigned char)3);
    t3 = t11;
    goto LAB9;

LAB10:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 2632U);
    t7 = *((char **)t2);
    t14 = *((int *)t7);
    t2 = (t0 + 3808U);
    t8 = *((char **)t2);
    t15 = *((int *)t8);
    t16 = (t14 != t15);
    if (t16 != 0)
        goto LAB13;

LAB15:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 5560);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(56, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t14 = *((int *)t2);
    t3 = (t14 != 8);
    if (t3 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 5432);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB17:
LAB14:    goto LAB11;

LAB13:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 2632U);
    t9 = *((char **)t2);
    t17 = *((int *)t9);
    t18 = (t17 + 1);
    t2 = (t0 + 5560);
    t19 = (t2 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    *((int *)t22) = t18;
    xsi_driver_first_trans_fast(t2);
    goto LAB14;

LAB16:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1512U);
    t5 = *((char **)t1);
    t4 = *((unsigned char *)t5);
    t1 = (t0 + 2312U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t17 = (t15 - 7);
    t23 = (t17 * -1);
    t24 = (1 * t23);
    t25 = (0U + t24);
    t1 = (t0 + 5624);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t19 = *((char **)t9);
    *((unsigned char *)t19) = t4;
    xsi_driver_first_trans_delta(t1, t25, 1, 0LL);
    xsi_set_current_line(58, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t14 = *((int *)t2);
    t15 = (t14 + 1);
    t1 = (t0 + 5304);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t15;
    xsi_driver_first_trans_fast(t1);
    goto LAB17;

LAB19:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 2632U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t1 = (t0 + 3808U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t10 = (t14 != t15);
    if (t10 != 0)
        goto LAB21;

LAB23:    xsi_set_current_line(68, ng0);
    t1 = (t0 + 5560);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(69, ng0);
    t3 = (1 == 1);
    if (t3 != 0)
        goto LAB24;

LAB26:    xsi_set_current_line(74, ng0);
    t1 = (t0 + 5432);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB25:
LAB22:    goto LAB11;

LAB21:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 2632U);
    t7 = *((char **)t1);
    t17 = *((int *)t7);
    t18 = (t17 + 1);
    t1 = (t0 + 5560);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t19 = (t9 + 56U);
    t20 = *((char **)t19);
    *((int *)t20) = t18;
    xsi_driver_first_trans_fast(t1);
    goto LAB22;

LAB24:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t1 = (t0 + 2792U);
    t5 = *((char **)t1);
    t1 = (t0 + 8912U);
    t10 = ieee_p_0017514958_sub_2060948036078220983_1861681735(IEEE_P_0017514958, t5, t1);
    t11 = (t4 == t10);
    if (t11 != 0)
        goto LAB27;

LAB29:
LAB28:    goto LAB25;

LAB27:    xsi_set_current_line(71, ng0);
    t6 = (t0 + 3928U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)3;
    goto LAB28;

LAB30:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 2632U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t1 = (t0 + 3808U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t10 = (t14 != t15);
    if (t10 != 0)
        goto LAB32;

LAB34:    xsi_set_current_line(82, ng0);
    t1 = (t0 + 5560);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(83, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t14 = *((int *)t2);
    t3 = (t14 != 2);
    if (t3 != 0)
        goto LAB35;

LAB37:    xsi_set_current_line(86, ng0);
    t1 = (t0 + 3928U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 != (unsigned char)3);
    if (t4 != 0)
        goto LAB38;

LAB40:
LAB39:    xsi_set_current_line(89, ng0);
    t1 = (t0 + 5432);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB36:
LAB33:    goto LAB11;

LAB32:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 2632U);
    t7 = *((char **)t1);
    t17 = *((int *)t7);
    t18 = (t17 + 1);
    t1 = (t0 + 5560);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t19 = (t9 + 56U);
    t20 = *((char **)t19);
    *((int *)t20) = t18;
    xsi_driver_first_trans_fast(t1);
    goto LAB33;

LAB35:    xsi_set_current_line(84, ng0);
    t1 = (t0 + 2472U);
    t5 = *((char **)t1);
    t15 = *((int *)t5);
    t17 = (t15 + 1);
    t1 = (t0 + 5368);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((int *)t9) = t17;
    xsi_driver_first_trans_fast(t1);
    goto LAB36;

LAB38:    xsi_set_current_line(87, ng0);
    t1 = (t0 + 5496);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB39;

LAB41:    xsi_set_current_line(93, ng0);
    t1 = (t0 + 2632U);
    t6 = *((char **)t1);
    t14 = *((int *)t6);
    t1 = (t0 + 3808U);
    t7 = *((char **)t1);
    t15 = *((int *)t7);
    t13 = (t14 != t15);
    if (t13 != 0)
        goto LAB46;

LAB48:    xsi_set_current_line(96, ng0);
    t1 = (t0 + 5560);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(97, ng0);
    t1 = (t0 + 5304);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(98, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t5 = (t0 + 5624);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(99, ng0);
    t1 = (t0 + 5368);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(100, ng0);
    t1 = (t0 + 5432);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);

LAB47:    goto LAB11;

LAB43:    t1 = (t0 + 1672U);
    t5 = *((char **)t1);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB45;

LAB46:    xsi_set_current_line(94, ng0);
    t1 = (t0 + 2632U);
    t8 = *((char **)t1);
    t17 = *((int *)t8);
    t18 = (t17 + 1);
    t1 = (t0 + 5560);
    t9 = (t1 + 56U);
    t19 = *((char **)t9);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    *((int *)t21) = t18;
    xsi_driver_first_trans_fast(t1);
    goto LAB47;

}


extern void work_a_2340374602_0218940177_init()
{
	static char *pe[] = {(void *)work_a_2340374602_0218940177_p_0};
	xsi_register_didat("work_a_2340374602_0218940177", "isim/RECEIVER_isim_beh.exe.sim/work/a_2340374602_0218940177.didat");
	xsi_register_executes(pe);
}
