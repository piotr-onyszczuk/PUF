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
static const char *ng0 = "/home/ise/Desktop/PUF/Initial_project/receiver_behav.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_0017514958;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_0017514958_sub_2060948036078220983_1861681735(char *, char *, char *);
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );
char *ieee_p_3620187407_sub_2255506239096166994_3965413181(char *, char *, char *, char *, int );


static void work_a_2482639415_1878664202_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;

LAB0:    t1 = (t0 + 4384U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 5264);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(36, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 4192);
    xsi_process_wait(t2, t7);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(37, ng0);
    t2 = (t0 + 5264);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(37, ng0);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_2482639415_1878664202_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    int64 t10;
    int64 t11;

LAB0:    t1 = (t0 + 4632U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t4);
    t2 = (t0 + 5328);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t5;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(42, ng0);
    t2 = (t0 + 3288U);
    t3 = *((char **)t2);
    t10 = *((int64 *)t3);
    t11 = (t10 / 2);
    t2 = (t0 + 4440);
    xsi_process_wait(t2, t11);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

}

unsigned char work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(char *t1, unsigned char t2, unsigned char t3)
{
    char t5[8];
    unsigned char t0;
    char *t6;
    char *t7;
    unsigned char t8;

LAB0:    t6 = (t5 + 4U);
    *((unsigned char *)t6) = t2;
    t7 = (t5 + 5U);
    *((unsigned char *)t7) = t3;
    t8 = (t3 == (unsigned char)0);
    if (t8 != 0)
        goto LAB2;

LAB4:
LAB3:    t8 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t2);
    t0 = t8;

LAB1:    return t0;
LAB2:    t0 = t2;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:;
}

static void work_a_2482639415_1878664202_p_2(char *t0)
{
    char t25[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    unsigned char t7;
    char *t8;
    char *t9;
    int64 t10;
    int t11;
    int t12;
    int t13;
    int t14;
    int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned char t19;
    unsigned char t20;
    char *t21;
    char *t22;
    char *t23;
    unsigned char t24;
    int64 t26;

LAB0:    t1 = (t0 + 4880U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 5392);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(53, ng0);
    t7 = work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(t0, (unsigned char)2, (unsigned char)0);
    t2 = (t0 + 5456);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = t7;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(54, ng0);
    t2 = (t0 + 8574);
    t4 = (t0 + 5520);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(55, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t3 = t2;
    memset(t3, (unsigned char)2, 8U);
    t4 = (t0 + 5584);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(56, ng0);
    t10 = (200 * 1000LL);
    t2 = (t0 + 4688);
    xsi_process_wait(t2, t10);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(57, ng0);

LAB8:
LAB9:    xsi_set_current_line(58, ng0);
    t7 = work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(t0, (unsigned char)3, (unsigned char)0);
    t2 = (t0 + 5392);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = t7;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(59, ng0);
    t2 = (t0 + 3408U);
    t3 = *((char **)t2);
    t10 = *((int64 *)t3);
    t2 = (t0 + 4688);
    xsi_process_wait(t2, t10);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB10:;
LAB11:    goto LAB2;

LAB12:    xsi_set_current_line(60, ng0);
    t11 = (8 - 1);
    t2 = (t0 + 8582);
    *((int *)t2) = 0;
    t3 = (t0 + 8586);
    *((int *)t3) = t11;
    t12 = 0;
    t13 = t11;

LAB16:    if (t12 <= t13)
        goto LAB17;

LAB19:    xsi_set_current_line(64, ng0);
    t7 = (1 == 1);
    if (t7 != 0)
        goto LAB25;

LAB27:
LAB26:    xsi_set_current_line(68, ng0);
    t11 = (2 - 1);
    t2 = (t0 + 8590);
    *((int *)t2) = 0;
    t3 = (t0 + 8594);
    *((int *)t3) = t11;
    t12 = 0;
    t13 = t11;

LAB32:    if (t12 <= t13)
        goto LAB33;

LAB35:    xsi_set_current_line(72, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t2 = (t0 + 8472U);
    t4 = ieee_p_3620187407_sub_2255506239096166994_3965413181(IEEE_P_3620187407, t25, t3, t2, 7);
    t5 = (t25 + 12U);
    t16 = *((unsigned int *)t5);
    t17 = (1U * t16);
    t7 = (8U != t17);
    if (t7 == 1)
        goto LAB41;

LAB42:    t6 = (t0 + 5520);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t21 = (t9 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t4, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 3288U);
    t3 = *((char **)t2);
    t10 = *((int64 *)t3);
    t26 = (10 * t10);
    t2 = (t0 + 4688);
    xsi_process_wait(t2, t26);

LAB45:    *((char **)t1) = &&LAB46;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB17:    xsi_set_current_line(61, ng0);
    t4 = (t0 + 1512U);
    t5 = *((char **)t4);
    t4 = (t0 + 8582);
    t14 = *((int *)t4);
    t15 = (t14 - 7);
    t16 = (t15 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, *((int *)t4));
    t17 = (1U * t16);
    t18 = (0 + t17);
    t6 = (t5 + t18);
    t7 = *((unsigned char *)t6);
    t19 = work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(t0, t7, (unsigned char)0);
    t20 = work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(t0, t19, (unsigned char)0);
    t8 = (t0 + 5456);
    t9 = (t8 + 56U);
    t21 = *((char **)t9);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    *((unsigned char *)t23) = t20;
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 3408U);
    t3 = *((char **)t2);
    t10 = *((int64 *)t3);
    t2 = (t0 + 4688);
    xsi_process_wait(t2, t10);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB18:    t2 = (t0 + 8582);
    t12 = *((int *)t2);
    t3 = (t0 + 8586);
    t13 = *((int *)t3);
    if (t12 == t13)
        goto LAB19;

LAB24:    t11 = (t12 + 1);
    t12 = t11;
    t4 = (t0 + 8582);
    *((int *)t4) = t12;
    goto LAB16;

LAB20:    goto LAB18;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB25:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t2 = (t0 + 8472U);
    t19 = ieee_p_0017514958_sub_2060948036078220983_1861681735(IEEE_P_0017514958, t3, t2);
    t20 = work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(t0, t19, (unsigned char)0);
    t24 = work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(t0, t20, (unsigned char)0);
    t4 = (t0 + 5456);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t24;
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(66, ng0);
    t2 = (t0 + 3408U);
    t3 = *((char **)t2);
    t10 = *((int64 *)t3);
    t2 = (t0 + 4688);
    xsi_process_wait(t2, t10);

LAB30:    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB28:    goto LAB26;

LAB29:    goto LAB28;

LAB31:    goto LAB29;

LAB33:    xsi_set_current_line(69, ng0);
    t7 = work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612(t0, (unsigned char)2, (unsigned char)0);
    t4 = (t0 + 5456);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t7;
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(70, ng0);
    t2 = (t0 + 3408U);
    t3 = *((char **)t2);
    t10 = *((int64 *)t3);
    t2 = (t0 + 4688);
    xsi_process_wait(t2, t10);

LAB38:    *((char **)t1) = &&LAB39;
    goto LAB1;

LAB34:    t2 = (t0 + 8590);
    t12 = *((int *)t2);
    t3 = (t0 + 8594);
    t13 = *((int *)t3);
    if (t12 == t13)
        goto LAB35;

LAB40:    t11 = (t12 + 1);
    t12 = t11;
    t4 = (t0 + 8590);
    *((int *)t4) = t12;
    goto LAB32;

LAB36:    goto LAB34;

LAB37:    goto LAB36;

LAB39:    goto LAB37;

LAB41:    xsi_size_not_matching(8U, t17, 0);
    goto LAB42;

LAB43:    goto LAB8;

LAB44:    goto LAB43;

LAB46:    goto LAB44;

}


extern void work_a_2482639415_1878664202_init()
{
	static char *pe[] = {(void *)work_a_2482639415_1878664202_p_0,(void *)work_a_2482639415_1878664202_p_1,(void *)work_a_2482639415_1878664202_p_2};
	static char *se[] = {(void *)work_a_2482639415_1878664202_sub_12550205946580078448_3137551486645019612};
	xsi_register_didat("work_a_2482639415_1878664202", "isim/RECEIVER_TB_isim_beh.exe.sim/work/a_2482639415_1878664202.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
