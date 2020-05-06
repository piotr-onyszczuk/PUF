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


static void work_a_1754743692_0218940177_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    int t13;
    unsigned char t14;
    unsigned char t15;
    char *t16;
    int t17;
    int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    int t26;

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
LAB3:    xsi_set_current_line(99, ng0);
    t1 = (t0 + 3768U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 5528);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t3;
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 5064);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(41, ng0);
    t1 = (t0 + 5144);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(42, ng0);
    t1 = (t0 + 5208);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(43, ng0);
    t1 = (t0 + 5272);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(44, ng0);
    t1 = (t0 + 3768U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((unsigned char *)t1) = (unsigned char)2;
    xsi_set_current_line(45, ng0);
    t1 = (t0 + 5336);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(46, ng0);
    t1 = (t0 + 5400);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 2152U);
    t6 = *((char **)t2);
    t11 = *((unsigned char *)t6);
    t12 = (t11 == (unsigned char)1);
    if (t12 != 0)
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
    t9 = (t4 == (unsigned char)0);
    if (t9 == 1)
        goto LAB43;

LAB44:    t3 = (unsigned char)0;

LAB45:    if (t3 != 0)
        goto LAB41;

LAB42:
LAB11:    goto LAB3;

LAB7:    t2 = (t0 + 1192U);
    t5 = *((char **)t2);
    t9 = *((unsigned char *)t5);
    t10 = (t9 == (unsigned char)3);
    t3 = t10;
    goto LAB9;

LAB10:    xsi_set_current_line(49, ng0);
    t2 = (t0 + 2312U);
    t7 = *((char **)t2);
    t13 = *((int *)t7);
    t14 = (t13 != 8);
    if (t14 != 0)
        goto LAB13;

LAB15:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 5272);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB14:    goto LAB11;

LAB13:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 1512U);
    t8 = *((char **)t2);
    t15 = *((unsigned char *)t8);
    t2 = (t0 + 2312U);
    t16 = *((char **)t2);
    t17 = *((int *)t16);
    t18 = (t17 - 7);
    t19 = (t18 * -1);
    t20 = (1 * t19);
    t21 = (0U + t20);
    t2 = (t0 + 5464);
    t22 = (t2 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    *((unsigned char *)t25) = t15;
    xsi_driver_first_trans_delta(t2, t21, 1, 0LL);
    xsi_set_current_line(51, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t17 = (t13 + 1);
    t1 = (t0 + 5144);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t17;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(52, ng0);
    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 3648U);
    t5 = *((char **)t1);
    t17 = *((int *)t5);
    t3 = (t13 != t17);
    if (t3 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 5400);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);

LAB17:    goto LAB14;

LAB16:    xsi_set_current_line(53, ng0);
    t1 = (t0 + 2632U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t26 = (t18 + 1);
    t1 = (t0 + 5400);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t16 = (t8 + 56U);
    t22 = *((char **)t16);
    *((int *)t22) = t26;
    xsi_driver_first_trans_fast(t1);
    goto LAB17;

LAB19:    xsi_set_current_line(61, ng0);
    t9 = (1 == 1);
    if (t9 != 0)
        goto LAB21;

LAB23:    xsi_set_current_line(71, ng0);
    t1 = (t0 + 5272);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB22:    goto LAB11;

LAB21:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 1512U);
    t5 = *((char **)t1);
    t10 = *((unsigned char *)t5);
    t1 = (t0 + 1032U);
    t6 = *((char **)t1);
    t1 = (t0 + 8560U);
    t11 = ieee_p_0017514958_sub_2060948036078220983_1861681735(IEEE_P_0017514958, t6, t1);
    t12 = (t10 == t11);
    if (t12 != 0)
        goto LAB24;

LAB26:
LAB25:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 3648U);
    t5 = *((char **)t1);
    t17 = *((int *)t5);
    t3 = (t13 != t17);
    if (t3 != 0)
        goto LAB27;

LAB29:    xsi_set_current_line(68, ng0);
    t1 = (t0 + 5400);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);

LAB28:    goto LAB22;

LAB24:    xsi_set_current_line(63, ng0);
    t7 = (t0 + 3768U);
    t8 = *((char **)t7);
    t7 = (t8 + 0);
    *((unsigned char *)t7) = (unsigned char)3;
    goto LAB25;

LAB27:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 2632U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t26 = (t18 + 1);
    t1 = (t0 + 5400);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t16 = (t8 + 56U);
    t22 = *((char **)t16);
    *((int *)t22) = t26;
    xsi_driver_first_trans_fast(t1);
    goto LAB28;

LAB30:    xsi_set_current_line(74, ng0);
    t1 = (t0 + 2472U);
    t5 = *((char **)t1);
    t13 = *((int *)t5);
    t9 = (t13 != 2);
    if (t9 != 0)
        goto LAB32;

LAB34:    xsi_set_current_line(82, ng0);
    t1 = (t0 + 3768U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 != (unsigned char)3);
    if (t4 != 0)
        goto LAB38;

LAB40:
LAB39:    xsi_set_current_line(85, ng0);
    t1 = (t0 + 5272);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB33:    goto LAB11;

LAB32:    xsi_set_current_line(75, ng0);
    t1 = (t0 + 2472U);
    t6 = *((char **)t1);
    t17 = *((int *)t6);
    t18 = (t17 + 1);
    t1 = (t0 + 5208);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t16 = (t8 + 56U);
    t22 = *((char **)t16);
    *((int *)t22) = t18;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(76, ng0);
    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 3648U);
    t5 = *((char **)t1);
    t17 = *((int *)t5);
    t3 = (t13 != t17);
    if (t3 != 0)
        goto LAB35;

LAB37:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 5400);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);

LAB36:    goto LAB33;

LAB35:    xsi_set_current_line(77, ng0);
    t1 = (t0 + 2632U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t26 = (t18 + 1);
    t1 = (t0 + 5400);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t16 = (t8 + 56U);
    t22 = *((char **)t16);
    *((int *)t22) = t26;
    xsi_driver_first_trans_fast(t1);
    goto LAB36;

LAB38:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 5336);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB39;

LAB41:    xsi_set_current_line(88, ng0);
    t1 = (t0 + 5144);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t16 = *((char **)t8);
    *((int *)t16) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(89, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t5 = (t0 + 5464);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t16 = *((char **)t8);
    memcpy(t16, t1, 8U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(90, ng0);
    t1 = (t0 + 5208);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(91, ng0);
    t1 = (t0 + 5272);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(92, ng0);
    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 3648U);
    t5 = *((char **)t1);
    t17 = *((int *)t5);
    t3 = (t13 != t17);
    if (t3 != 0)
        goto LAB46;

LAB48:    xsi_set_current_line(95, ng0);
    t1 = (t0 + 5400);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);

LAB47:    goto LAB11;

LAB43:    t1 = (t0 + 1672U);
    t5 = *((char **)t1);
    t10 = *((unsigned char *)t5);
    t11 = (t10 == (unsigned char)3);
    t3 = t11;
    goto LAB45;

LAB46:    xsi_set_current_line(93, ng0);
    t1 = (t0 + 2632U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t26 = (t18 + 1);
    t1 = (t0 + 5400);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t16 = (t8 + 56U);
    t22 = *((char **)t16);
    *((int *)t22) = t26;
    xsi_driver_first_trans_fast(t1);
    goto LAB47;

}


extern void work_a_1754743692_0218940177_init()
{
	static char *pe[] = {(void *)work_a_1754743692_0218940177_p_0};
	xsi_register_didat("work_a_1754743692_0218940177", "isim/RECEIVER_TB_isim_beh.exe.sim/work/a_1754743692_0218940177.didat");
	xsi_register_executes(pe);
}
