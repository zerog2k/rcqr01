	.cpu cortex-m0
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"boards.c"
	.text
.Ltext0:
	.section	.text.nrf_gpio_pin_port_decode,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_pin_port_decode, %function
nrf_gpio_pin_port_decode:
.LFB37:
	.file 1 "/Users/jens/build/nrf/nRF5_SDK_12.3.0/components/drivers_nrf/hal/nrf_gpio.h"
	.loc 1 463 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI0:
	str	r0, [sp, #4]
	.loc 1 467 0
	movs	r3, #160
	lsls	r3, r3, #23
	.loc 1 479 0
	movs	r0, r3
	add	sp, sp, #8
	@ sp needed
	bx	lr
.LFE37:
	.size	nrf_gpio_pin_port_decode, .-nrf_gpio_pin_port_decode
	.section	.text.nrf_gpio_cfg,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_cfg, %function
nrf_gpio_cfg:
.LFB40:
	.loc 1 511 0
	@ args = 8, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI1:
	sub	sp, sp, #16
.LCFI2:
	str	r0, [sp, #4]
	movs	r4, r1
	movs	r0, r2
	movs	r1, r3
	mov	r3, sp
	adds	r3, r3, #3
	adds	r2, r4, #0
	strb	r2, [r3]
	mov	r3, sp
	adds	r3, r3, #2
	adds	r2, r0, #0
	strb	r2, [r3]
	mov	r3, sp
	adds	r3, r3, #1
	adds	r2, r1, #0
	strb	r2, [r3]
	.loc 1 512 0
	add	r3, sp, #4
	movs	r0, r3
	bl	nrf_gpio_pin_port_decode
	movs	r3, r0
	str	r3, [sp, #12]
	.loc 1 514 0
	ldr	r2, [sp, #4]
	mov	r3, sp
	adds	r3, r3, #3
	ldrb	r1, [r3]
	.loc 1 515 0
	mov	r3, sp
	adds	r3, r3, #2
	ldrb	r3, [r3]
	lsls	r3, r3, #1
	orrs	r1, r3
	.loc 1 516 0
	mov	r3, sp
	adds	r3, r3, #1
	ldrb	r3, [r3]
	lsls	r3, r3, #2
	orrs	r1, r3
	.loc 1 517 0
	add	r3, sp, #24
	ldrb	r3, [r3]
	lsls	r3, r3, #8
	orrs	r1, r3
	.loc 1 518 0
	add	r3, sp, #28
	ldrb	r3, [r3]
	lsls	r3, r3, #16
	orrs	r1, r3
	.loc 1 514 0
	ldr	r3, [sp, #12]
	adds	r2, r2, #193
	adds	r2, r2, #255
	lsls	r2, r2, #2
	str	r1, [r2, r3]
	.loc 1 519 0
	nop
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
.LFE40:
	.size	nrf_gpio_cfg, .-nrf_gpio_cfg
	.section	.text.nrf_gpio_cfg_output,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_cfg_output, %function
nrf_gpio_cfg_output:
.LFB41:
	.loc 1 523 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI3:
	sub	sp, sp, #20
.LCFI4:
	str	r0, [sp, #12]
	.loc 1 524 0
	ldr	r0, [sp, #12]
	movs	r3, #0
	str	r3, [sp, #4]
	movs	r3, #0
	str	r3, [sp]
	movs	r3, #0
	movs	r2, #1
	movs	r1, #1
	bl	nrf_gpio_cfg
	.loc 1 531 0
	nop
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.LFE41:
	.size	nrf_gpio_cfg_output, .-nrf_gpio_cfg_output
	.section	.text.nrf_gpio_cfg_input,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_cfg_input, %function
nrf_gpio_cfg_input:
.LFB42:
	.loc 1 535 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI5:
	sub	sp, sp, #20
.LCFI6:
	str	r0, [sp, #12]
	movs	r2, r1
	movs	r3, #11
	add	r3, r3, sp
	strb	r2, [r3]
	.loc 1 536 0
	movs	r3, #11
	add	r3, r3, sp
	ldrb	r2, [r3]
	ldr	r0, [sp, #12]
	movs	r3, #0
	str	r3, [sp, #4]
	movs	r3, #0
	str	r3, [sp]
	movs	r3, r2
	movs	r2, #0
	movs	r1, #0
	bl	nrf_gpio_cfg
	.loc 1 543 0
	nop
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.LFE42:
	.size	nrf_gpio_cfg_input, .-nrf_gpio_cfg_input
	.section	.text.nrf_gpio_pin_set,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_pin_set, %function
nrf_gpio_pin_set:
.LFB49:
	.loc 1 623 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI7:
	sub	sp, sp, #20
.LCFI8:
	str	r0, [sp, #4]
	.loc 1 624 0
	add	r3, sp, #4
	movs	r0, r3
	bl	nrf_gpio_pin_port_decode
	movs	r3, r0
	str	r3, [sp, #12]
	.loc 1 626 0
	ldr	r3, [sp, #4]
	movs	r2, #1
	lsls	r2, r2, r3
	ldr	r3, [sp, #12]
	movs	r1, r2
	movs	r0, r3
	bl	nrf_gpio_port_out_set
	.loc 1 627 0
	nop
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.LFE49:
	.size	nrf_gpio_pin_set, .-nrf_gpio_pin_set
	.section	.text.nrf_gpio_pin_clear,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_pin_clear, %function
nrf_gpio_pin_clear:
.LFB50:
	.loc 1 631 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI9:
	sub	sp, sp, #20
.LCFI10:
	str	r0, [sp, #4]
	.loc 1 632 0
	add	r3, sp, #4
	movs	r0, r3
	bl	nrf_gpio_pin_port_decode
	movs	r3, r0
	str	r3, [sp, #12]
	.loc 1 634 0
	ldr	r3, [sp, #4]
	movs	r2, #1
	lsls	r2, r2, r3
	ldr	r3, [sp, #12]
	movs	r1, r2
	movs	r0, r3
	bl	nrf_gpio_port_out_clear
	.loc 1 635 0
	nop
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.LFE50:
	.size	nrf_gpio_pin_clear, .-nrf_gpio_pin_clear
	.section	.text.nrf_gpio_pin_toggle,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_pin_toggle, %function
nrf_gpio_pin_toggle:
.LFB51:
	.loc 1 639 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI11:
	sub	sp, sp, #20
.LCFI12:
	str	r0, [sp, #4]
	.loc 1 640 0
	add	r3, sp, #4
	movs	r0, r3
	bl	nrf_gpio_pin_port_decode
	movs	r3, r0
	str	r3, [sp, #12]
	.loc 1 641 0
	ldr	r3, [sp, #12]
	ldr	r2, .L9
	ldr	r3, [r3, r2]
	str	r3, [sp, #8]
	.loc 1 643 0
	ldr	r3, [sp, #8]
	mvns	r3, r3
	ldr	r2, [sp, #4]
	movs	r1, #1
	lsls	r1, r1, r2
	movs	r2, r1
	ands	r2, r3
	movs	r1, r2
	ldr	r2, [sp, #12]
	movs	r3, #161
	lsls	r3, r3, #3
	str	r1, [r2, r3]
	.loc 1 644 0
	ldr	r3, [sp, #4]
	movs	r2, #1
	lsls	r2, r2, r3
	movs	r3, r2
	ldr	r2, [sp, #8]
	ands	r2, r3
	ldr	r3, [sp, #12]
	ldr	r1, .L9+4
	str	r2, [r3, r1]
	.loc 1 645 0
	nop
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.L10:
	.align	2
.L9:
	.word	1284
	.word	1292
.LFE51:
	.size	nrf_gpio_pin_toggle, .-nrf_gpio_pin_toggle
	.section	.text.nrf_gpio_pin_write,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_pin_write, %function
nrf_gpio_pin_write:
.LFB52:
	.loc 1 649 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI13:
	sub	sp, sp, #12
.LCFI14:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 650 0
	ldr	r3, [sp]
	cmp	r3, #0
	bne	.L12
	.loc 1 652 0
	ldr	r3, [sp, #4]
	movs	r0, r3
	bl	nrf_gpio_pin_clear
	.loc 1 658 0
	b	.L14
.L12:
	.loc 1 656 0
	ldr	r3, [sp, #4]
	movs	r0, r3
	bl	nrf_gpio_pin_set
.L14:
	.loc 1 658 0
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.LFE52:
	.size	nrf_gpio_pin_write, .-nrf_gpio_pin_write
	.section	.text.nrf_gpio_pin_read,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_pin_read, %function
nrf_gpio_pin_read:
.LFB53:
	.loc 1 662 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI15:
	sub	sp, sp, #20
.LCFI16:
	str	r0, [sp, #4]
	.loc 1 663 0
	add	r3, sp, #4
	movs	r0, r3
	bl	nrf_gpio_pin_port_decode
	movs	r3, r0
	str	r3, [sp, #12]
	.loc 1 665 0
	ldr	r3, [sp, #12]
	movs	r0, r3
	bl	nrf_gpio_port_in_read
	movs	r2, r0
	ldr	r3, [sp, #4]
	lsrs	r2, r2, r3
	movs	r3, r2
	movs	r2, #1
	ands	r3, r2
	.loc 1 666 0
	movs	r0, r3
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.LFE53:
	.size	nrf_gpio_pin_read, .-nrf_gpio_pin_read
	.section	.text.nrf_gpio_pin_out_read,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_pin_out_read, %function
nrf_gpio_pin_out_read:
.LFB54:
	.loc 1 670 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI17:
	sub	sp, sp, #20
.LCFI18:
	str	r0, [sp, #4]
	.loc 1 671 0
	add	r3, sp, #4
	movs	r0, r3
	bl	nrf_gpio_pin_port_decode
	movs	r3, r0
	str	r3, [sp, #12]
	.loc 1 673 0
	ldr	r3, [sp, #12]
	movs	r0, r3
	bl	nrf_gpio_port_out_read
	movs	r2, r0
	ldr	r3, [sp, #4]
	lsrs	r2, r2, r3
	movs	r3, r2
	movs	r2, #1
	ands	r3, r2
	.loc 1 674 0
	movs	r0, r3
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.LFE54:
	.size	nrf_gpio_pin_out_read, .-nrf_gpio_pin_out_read
	.section	.text.nrf_gpio_port_in_read,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_port_in_read, %function
nrf_gpio_port_in_read:
.LFB60:
	.loc 1 711 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI19:
	str	r0, [sp, #4]
	.loc 1 712 0
	ldr	r2, [sp, #4]
	movs	r3, #162
	lsls	r3, r3, #3
	ldr	r3, [r2, r3]
	.loc 1 713 0
	movs	r0, r3
	add	sp, sp, #8
	@ sp needed
	bx	lr
.LFE60:
	.size	nrf_gpio_port_in_read, .-nrf_gpio_port_in_read
	.section	.text.nrf_gpio_port_out_read,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_port_out_read, %function
nrf_gpio_port_out_read:
.LFB61:
	.loc 1 717 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI20:
	str	r0, [sp, #4]
	.loc 1 718 0
	ldr	r3, [sp, #4]
	ldr	r2, .L23
	ldr	r3, [r3, r2]
	.loc 1 719 0
	movs	r0, r3
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L24:
	.align	2
.L23:
	.word	1284
.LFE61:
	.size	nrf_gpio_port_out_read, .-nrf_gpio_port_out_read
	.section	.text.nrf_gpio_port_out_set,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_port_out_set, %function
nrf_gpio_port_out_set:
.LFB63:
	.loc 1 729 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI21:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 730 0
	ldr	r2, [sp, #4]
	movs	r3, #161
	lsls	r3, r3, #3
	ldr	r1, [sp]
	str	r1, [r2, r3]
	.loc 1 731 0
	nop
	add	sp, sp, #8
	@ sp needed
	bx	lr
.LFE63:
	.size	nrf_gpio_port_out_set, .-nrf_gpio_port_out_set
	.section	.text.nrf_gpio_port_out_clear,"ax",%progbits
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	nrf_gpio_port_out_clear, %function
nrf_gpio_port_out_clear:
.LFB64:
	.loc 1 735 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI22:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 736 0
	ldr	r3, [sp, #4]
	ldr	r1, .L27
	ldr	r2, [sp]
	str	r2, [r3, r1]
	.loc 1 737 0
	nop
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L28:
	.align	2
.L27:
	.word	1292
.LFE64:
	.size	nrf_gpio_port_out_clear, .-nrf_gpio_port_out_clear
	.section	.rodata.m_board_led_list,"a",%progbits
	.align	2
	.type	m_board_led_list, %object
	.size	m_board_led_list, 4
m_board_led_list:
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.section	.rodata.m_board_btn_list,"a",%progbits
	.align	2
	.type	m_board_btn_list, %object
	.size	m_board_btn_list, 4
m_board_btn_list:
	.byte	16
	.byte	17
	.space	2
	.section	.text.bsp_board_led_state_get,"ax",%progbits
	.align	1
	.global	bsp_board_led_state_get
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_led_state_get, %function
bsp_board_led_state_get:
.LFB66:
	.file 2 "/Users/jens/build/nrf/nRF5_SDK_12.3.0/components/boards/boards.c"
	.loc 2 54 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI23:
	sub	sp, sp, #20
.LCFI24:
	str	r0, [sp, #4]
	.loc 2 56 0
	ldr	r2, .L31
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r0, r3
	bl	nrf_gpio_pin_out_read
	movs	r2, r0
	movs	r3, #15
	add	r3, r3, sp
	subs	r1, r2, #1
	sbcs	r2, r2, r1
	strb	r2, [r3]
	.loc 2 57 0
	movs	r3, #15
	add	r3, r3, sp
	ldrb	r3, [r3]
	subs	r2, r3, #1
	sbcs	r3, r3, r2
	uxtb	r3, r3
	movs	r2, #1
	eors	r3, r2
	uxtb	r3, r3
	adds	r2, r3, #0
	movs	r3, #1
	ands	r3, r2
	uxtb	r3, r3
	.loc 2 58 0
	movs	r0, r3
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.L32:
	.align	2
.L31:
	.word	m_board_led_list
.LFE66:
	.size	bsp_board_led_state_get, .-bsp_board_led_state_get
	.section	.text.bsp_board_led_on,"ax",%progbits
	.align	1
	.global	bsp_board_led_on
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_led_on, %function
bsp_board_led_on:
.LFB67:
	.loc 2 61 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI25:
	sub	sp, sp, #12
.LCFI26:
	str	r0, [sp, #4]
	.loc 2 63 0
	ldr	r2, .L34
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r1, #0
	movs	r0, r3
	bl	nrf_gpio_pin_write
	.loc 2 64 0
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.L35:
	.align	2
.L34:
	.word	m_board_led_list
.LFE67:
	.size	bsp_board_led_on, .-bsp_board_led_on
	.section	.text.bsp_board_led_off,"ax",%progbits
	.align	1
	.global	bsp_board_led_off
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_led_off, %function
bsp_board_led_off:
.LFB68:
	.loc 2 67 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI27:
	sub	sp, sp, #12
.LCFI28:
	str	r0, [sp, #4]
	.loc 2 69 0
	ldr	r2, .L37
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r1, #1
	movs	r0, r3
	bl	nrf_gpio_pin_write
	.loc 2 70 0
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.L38:
	.align	2
.L37:
	.word	m_board_led_list
.LFE68:
	.size	bsp_board_led_off, .-bsp_board_led_off
	.section	.text.bsp_board_leds_off,"ax",%progbits
	.align	1
	.global	bsp_board_leds_off
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_leds_off, %function
bsp_board_leds_off:
.LFB69:
	.loc 2 73 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI29:
	sub	sp, sp, #12
.LCFI30:
	.loc 2 75 0
	movs	r3, #0
	str	r3, [sp, #4]
	b	.L40
.L41:
	.loc 2 77 0 discriminator 3
	ldr	r3, [sp, #4]
	movs	r0, r3
	bl	bsp_board_led_off
	.loc 2 75 0 discriminator 3
	ldr	r3, [sp, #4]
	adds	r3, r3, #1
	str	r3, [sp, #4]
.L40:
	.loc 2 75 0 is_stmt 0 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L41
	.loc 2 79 0 is_stmt 1
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.LFE69:
	.size	bsp_board_leds_off, .-bsp_board_leds_off
	.section	.text.bsp_board_leds_on,"ax",%progbits
	.align	1
	.global	bsp_board_leds_on
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_leds_on, %function
bsp_board_leds_on:
.LFB70:
	.loc 2 82 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI31:
	sub	sp, sp, #12
.LCFI32:
	.loc 2 84 0
	movs	r3, #0
	str	r3, [sp, #4]
	b	.L43
.L44:
	.loc 2 86 0 discriminator 3
	ldr	r3, [sp, #4]
	movs	r0, r3
	bl	bsp_board_led_on
	.loc 2 84 0 discriminator 3
	ldr	r3, [sp, #4]
	adds	r3, r3, #1
	str	r3, [sp, #4]
.L43:
	.loc 2 84 0 is_stmt 0 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L44
	.loc 2 88 0 is_stmt 1
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.LFE70:
	.size	bsp_board_leds_on, .-bsp_board_leds_on
	.section	.text.bsp_board_led_invert,"ax",%progbits
	.align	1
	.global	bsp_board_led_invert
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_led_invert, %function
bsp_board_led_invert:
.LFB71:
	.loc 2 91 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI33:
	sub	sp, sp, #12
.LCFI34:
	str	r0, [sp, #4]
	.loc 2 93 0
	ldr	r2, .L46
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r0, r3
	bl	nrf_gpio_pin_toggle
	.loc 2 94 0
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.L47:
	.align	2
.L46:
	.word	m_board_led_list
.LFE71:
	.size	bsp_board_led_invert, .-bsp_board_led_invert
	.section	.text.bsp_board_leds_init,"ax",%progbits
	.align	1
	.global	bsp_board_leds_init
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_leds_init, %function
bsp_board_leds_init:
.LFB72:
	.loc 2 97 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI35:
	sub	sp, sp, #12
.LCFI36:
	.loc 2 99 0
	movs	r3, #0
	str	r3, [sp, #4]
	b	.L49
.L50:
	.loc 2 101 0 discriminator 3
	ldr	r2, .L51
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r0, r3
	bl	nrf_gpio_cfg_output
	.loc 2 99 0 discriminator 3
	ldr	r3, [sp, #4]
	adds	r3, r3, #1
	str	r3, [sp, #4]
.L49:
	.loc 2 99 0 is_stmt 0 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L50
	.loc 2 103 0 is_stmt 1
	bl	bsp_board_leds_off
	.loc 2 104 0
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.L52:
	.align	2
.L51:
	.word	m_board_led_list
.LFE72:
	.size	bsp_board_leds_init, .-bsp_board_leds_init
	.section	.text.bsp_board_led_idx_to_pin,"ax",%progbits
	.align	1
	.global	bsp_board_led_idx_to_pin
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_led_idx_to_pin, %function
bsp_board_led_idx_to_pin:
.LFB73:
	.loc 2 107 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI37:
	str	r0, [sp, #4]
	.loc 2 109 0
	ldr	r2, .L55
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	.loc 2 110 0
	movs	r0, r3
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L56:
	.align	2
.L55:
	.word	m_board_led_list
.LFE73:
	.size	bsp_board_led_idx_to_pin, .-bsp_board_led_idx_to_pin
	.section	.text.bsp_board_pin_to_led_idx,"ax",%progbits
	.align	1
	.global	bsp_board_pin_to_led_idx
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_pin_to_led_idx, %function
bsp_board_pin_to_led_idx:
.LFB74:
	.loc 2 113 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
.LCFI38:
	str	r0, [sp, #4]
	.loc 2 114 0
	movs	r3, #1
	rsbs	r3, r3, #0
	str	r3, [sp, #12]
	.loc 2 116 0
	movs	r3, #0
	str	r3, [sp, #8]
	b	.L58
.L61:
	.loc 2 118 0
	ldr	r2, .L63
	ldr	r3, [sp, #8]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r2, r3
	ldr	r3, [sp, #4]
	cmp	r2, r3
	bne	.L59
	.loc 2 120 0
	ldr	r3, [sp, #8]
	str	r3, [sp, #12]
	.loc 2 121 0
	b	.L60
.L59:
	.loc 2 116 0 discriminator 2
	ldr	r3, [sp, #8]
	adds	r3, r3, #1
	str	r3, [sp, #8]
.L58:
	.loc 2 116 0 is_stmt 0 discriminator 1
	ldr	r3, [sp, #8]
	cmp	r3, #3
	bls	.L61
.L60:
	.loc 2 124 0 is_stmt 1
	ldr	r3, [sp, #12]
	.loc 2 125 0
	movs	r0, r3
	add	sp, sp, #16
	@ sp needed
	bx	lr
.L64:
	.align	2
.L63:
	.word	m_board_led_list
.LFE74:
	.size	bsp_board_pin_to_led_idx, .-bsp_board_pin_to_led_idx
	.section	.text.bsp_board_button_state_get,"ax",%progbits
	.align	1
	.global	bsp_board_button_state_get
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_button_state_get, %function
bsp_board_button_state_get:
.LFB75:
	.loc 2 130 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI39:
	sub	sp, sp, #20
.LCFI40:
	str	r0, [sp, #4]
	.loc 2 132 0
	ldr	r2, .L67
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r0, r3
	bl	nrf_gpio_pin_read
	movs	r2, r0
	movs	r3, #15
	add	r3, r3, sp
	subs	r1, r2, #1
	sbcs	r2, r2, r1
	strb	r2, [r3]
	.loc 2 133 0
	movs	r3, #15
	add	r3, r3, sp
	ldrb	r3, [r3]
	subs	r2, r3, #1
	sbcs	r3, r3, r2
	uxtb	r3, r3
	movs	r2, #1
	eors	r3, r2
	uxtb	r3, r3
	adds	r2, r3, #0
	movs	r3, #1
	ands	r3, r2
	uxtb	r3, r3
	.loc 2 134 0
	movs	r0, r3
	add	sp, sp, #20
	@ sp needed
	pop	{pc}
.L68:
	.align	2
.L67:
	.word	m_board_btn_list
.LFE75:
	.size	bsp_board_button_state_get, .-bsp_board_button_state_get
	.section	.text.bsp_board_buttons_init,"ax",%progbits
	.align	1
	.global	bsp_board_buttons_init
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_buttons_init, %function
bsp_board_buttons_init:
.LFB76:
	.loc 2 137 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI41:
	sub	sp, sp, #12
.LCFI42:
	.loc 2 139 0
	movs	r3, #0
	str	r3, [sp, #4]
	b	.L70
.L71:
	.loc 2 141 0 discriminator 3
	ldr	r2, .L72
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r1, #3
	movs	r0, r3
	bl	nrf_gpio_cfg_input
	.loc 2 139 0 discriminator 3
	ldr	r3, [sp, #4]
	adds	r3, r3, #1
	str	r3, [sp, #4]
.L70:
	.loc 2 139 0 is_stmt 0 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L71
	.loc 2 143 0 is_stmt 1
	nop
	add	sp, sp, #12
	@ sp needed
	pop	{pc}
.L73:
	.align	2
.L72:
	.word	m_board_btn_list
.LFE76:
	.size	bsp_board_buttons_init, .-bsp_board_buttons_init
	.section	.text.bsp_board_pin_to_button_idx,"ax",%progbits
	.align	1
	.global	bsp_board_pin_to_button_idx
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_pin_to_button_idx, %function
bsp_board_pin_to_button_idx:
.LFB77:
	.loc 2 146 0
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
.LCFI43:
	str	r0, [sp, #4]
	.loc 2 148 0
	movs	r3, #1
	rsbs	r3, r3, #0
	str	r3, [sp, #8]
	.loc 2 149 0
	movs	r3, #0
	str	r3, [sp, #12]
	b	.L75
.L78:
	.loc 2 151 0
	ldr	r2, .L80
	ldr	r3, [sp, #12]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	movs	r2, r3
	ldr	r3, [sp, #4]
	cmp	r2, r3
	bne	.L76
	.loc 2 153 0
	ldr	r3, [sp, #12]
	str	r3, [sp, #8]
	.loc 2 154 0
	b	.L77
.L76:
	.loc 2 149 0 discriminator 2
	ldr	r3, [sp, #12]
	adds	r3, r3, #1
	str	r3, [sp, #12]
.L75:
	.loc 2 149 0 is_stmt 0 discriminator 1
	ldr	r3, [sp, #12]
	cmp	r3, #3
	bls	.L78
.L77:
	.loc 2 157 0 is_stmt 1
	ldr	r3, [sp, #8]
	.loc 2 158 0
	movs	r0, r3
	add	sp, sp, #16
	@ sp needed
	bx	lr
.L81:
	.align	2
.L80:
	.word	m_board_btn_list
.LFE77:
	.size	bsp_board_pin_to_button_idx, .-bsp_board_pin_to_button_idx
	.section	.text.bsp_board_button_idx_to_pin,"ax",%progbits
	.align	1
	.global	bsp_board_button_idx_to_pin
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	bsp_board_button_idx_to_pin, %function
bsp_board_button_idx_to_pin:
.LFB78:
	.loc 2 161 0
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI44:
	str	r0, [sp, #4]
	.loc 2 163 0
	ldr	r2, .L84
	ldr	r3, [sp, #4]
	adds	r3, r2, r3
	ldrb	r3, [r3]
	.loc 2 164 0
	movs	r0, r3
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L85:
	.align	2
.L84:
	.word	m_board_btn_list
.LFE78:
	.size	bsp_board_button_idx_to_pin, .-bsp_board_button_idx_to_pin
	.section	.debug_frame,"",%progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x3
	.ascii	"\000"
	.uleb128 0x1
	.sleb128 -4
	.uleb128 0xe
	.byte	0xc
	.uleb128 0xd
	.uleb128 0
	.align	2
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.byte	0x4
	.4byte	.LCFI0-.LFB37
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.byte	0x4
	.4byte	.LCFI1-.LFB40
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.byte	0x4
	.4byte	.LCFI3-.LFB41
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.byte	0x4
	.4byte	.LCFI5-.LFB42
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB49
	.4byte	.LFE49-.LFB49
	.byte	0x4
	.4byte	.LCFI7-.LFB49
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI8-.LCFI7
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB50
	.4byte	.LFE50-.LFB50
	.byte	0x4
	.4byte	.LCFI9-.LFB50
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI10-.LCFI9
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB51
	.4byte	.LFE51-.LFB51
	.byte	0x4
	.4byte	.LCFI11-.LFB51
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI12-.LCFI11
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB52
	.4byte	.LFE52-.LFB52
	.byte	0x4
	.4byte	.LCFI13-.LFB52
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI14-.LCFI13
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB53
	.4byte	.LFE53-.LFB53
	.byte	0x4
	.4byte	.LCFI15-.LFB53
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI16-.LCFI15
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB54
	.4byte	.LFE54-.LFB54
	.byte	0x4
	.4byte	.LCFI17-.LFB54
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI18-.LCFI17
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE18:
.LSFDE20:
	.4byte	.LEFDE20-.LASFDE20
.LASFDE20:
	.4byte	.Lframe0
	.4byte	.LFB60
	.4byte	.LFE60-.LFB60
	.byte	0x4
	.4byte	.LCFI19-.LFB60
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE20:
.LSFDE22:
	.4byte	.LEFDE22-.LASFDE22
.LASFDE22:
	.4byte	.Lframe0
	.4byte	.LFB61
	.4byte	.LFE61-.LFB61
	.byte	0x4
	.4byte	.LCFI20-.LFB61
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE22:
.LSFDE24:
	.4byte	.LEFDE24-.LASFDE24
.LASFDE24:
	.4byte	.Lframe0
	.4byte	.LFB63
	.4byte	.LFE63-.LFB63
	.byte	0x4
	.4byte	.LCFI21-.LFB63
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE24:
.LSFDE26:
	.4byte	.LEFDE26-.LASFDE26
.LASFDE26:
	.4byte	.Lframe0
	.4byte	.LFB64
	.4byte	.LFE64-.LFB64
	.byte	0x4
	.4byte	.LCFI22-.LFB64
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE26:
.LSFDE28:
	.4byte	.LEFDE28-.LASFDE28
.LASFDE28:
	.4byte	.Lframe0
	.4byte	.LFB66
	.4byte	.LFE66-.LFB66
	.byte	0x4
	.4byte	.LCFI23-.LFB66
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI24-.LCFI23
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE28:
.LSFDE30:
	.4byte	.LEFDE30-.LASFDE30
.LASFDE30:
	.4byte	.Lframe0
	.4byte	.LFB67
	.4byte	.LFE67-.LFB67
	.byte	0x4
	.4byte	.LCFI25-.LFB67
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI26-.LCFI25
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE30:
.LSFDE32:
	.4byte	.LEFDE32-.LASFDE32
.LASFDE32:
	.4byte	.Lframe0
	.4byte	.LFB68
	.4byte	.LFE68-.LFB68
	.byte	0x4
	.4byte	.LCFI27-.LFB68
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI28-.LCFI27
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE32:
.LSFDE34:
	.4byte	.LEFDE34-.LASFDE34
.LASFDE34:
	.4byte	.Lframe0
	.4byte	.LFB69
	.4byte	.LFE69-.LFB69
	.byte	0x4
	.4byte	.LCFI29-.LFB69
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI30-.LCFI29
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE34:
.LSFDE36:
	.4byte	.LEFDE36-.LASFDE36
.LASFDE36:
	.4byte	.Lframe0
	.4byte	.LFB70
	.4byte	.LFE70-.LFB70
	.byte	0x4
	.4byte	.LCFI31-.LFB70
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI32-.LCFI31
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE36:
.LSFDE38:
	.4byte	.LEFDE38-.LASFDE38
.LASFDE38:
	.4byte	.Lframe0
	.4byte	.LFB71
	.4byte	.LFE71-.LFB71
	.byte	0x4
	.4byte	.LCFI33-.LFB71
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI34-.LCFI33
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE38:
.LSFDE40:
	.4byte	.LEFDE40-.LASFDE40
.LASFDE40:
	.4byte	.Lframe0
	.4byte	.LFB72
	.4byte	.LFE72-.LFB72
	.byte	0x4
	.4byte	.LCFI35-.LFB72
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI36-.LCFI35
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE40:
.LSFDE42:
	.4byte	.LEFDE42-.LASFDE42
.LASFDE42:
	.4byte	.Lframe0
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.byte	0x4
	.4byte	.LCFI37-.LFB73
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE42:
.LSFDE44:
	.4byte	.LEFDE44-.LASFDE44
.LASFDE44:
	.4byte	.Lframe0
	.4byte	.LFB74
	.4byte	.LFE74-.LFB74
	.byte	0x4
	.4byte	.LCFI38-.LFB74
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE44:
.LSFDE46:
	.4byte	.LEFDE46-.LASFDE46
.LASFDE46:
	.4byte	.Lframe0
	.4byte	.LFB75
	.4byte	.LFE75-.LFB75
	.byte	0x4
	.4byte	.LCFI39-.LFB75
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI40-.LCFI39
	.byte	0xe
	.uleb128 0x18
	.align	2
.LEFDE46:
.LSFDE48:
	.4byte	.LEFDE48-.LASFDE48
.LASFDE48:
	.4byte	.Lframe0
	.4byte	.LFB76
	.4byte	.LFE76-.LFB76
	.byte	0x4
	.4byte	.LCFI41-.LFB76
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI42-.LCFI41
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE48:
.LSFDE50:
	.4byte	.LEFDE50-.LASFDE50
.LASFDE50:
	.4byte	.Lframe0
	.4byte	.LFB77
	.4byte	.LFE77-.LFB77
	.byte	0x4
	.4byte	.LCFI43-.LFB77
	.byte	0xe
	.uleb128 0x10
	.align	2
.LEFDE50:
.LSFDE52:
	.4byte	.LEFDE52-.LASFDE52
.LASFDE52:
	.4byte	.Lframe0
	.4byte	.LFB78
	.4byte	.LFE78-.LFB78
	.byte	0x4
	.4byte	.LCFI44-.LFB78
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE52:
	.text
.Letext0:
	.file 3 "/Applications/SEGGER Embedded Studio 3.24/include/stdint.h"
	.file 4 "/Users/jens/build/nrf/nRF5_SDK_12.3.0/components/device/nrf51.h"
	.file 5 "/Applications/SEGGER Embedded Studio 3.24/include/__crossworks.h"
	.file 6 "/Users/jens/build/nrf/nRF5_SDK_12.3.0/components/toolchain/system_nrf51.h"
	.file 7 "/Applications/SEGGER Embedded Studio 3.24/include/stdio.h"
	.file 8 "/Users/jens/build/nrf/nRF5_SDK_12.3.0/components/libraries/util/sdk_errors.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0xda7
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF173
	.byte	0xc
	.4byte	.LASF174
	.4byte	.LASF175
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x3
	.4byte	.LASF3
	.byte	0x3
	.byte	0x10
	.4byte	0x3c
	.uleb128 0x4
	.4byte	0x2c
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x4
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x3
	.4byte	.LASF4
	.byte	0x3
	.byte	0x16
	.4byte	0x5a
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x3
	.4byte	.LASF6
	.byte	0x3
	.byte	0x18
	.4byte	0x7d
	.uleb128 0x6
	.4byte	0x68
	.uleb128 0x4
	.4byte	0x73
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x7
	.4byte	.LASF72
	.byte	0x6
	.byte	0x29
	.4byte	0x68
	.uleb128 0x8
	.4byte	0x73
	.4byte	0xb4
	.uleb128 0x9
	.4byte	0x92
	.byte	0x1f
	.byte	0
	.uleb128 0x6
	.4byte	0xa4
	.uleb128 0xa
	.2byte	0x780
	.byte	0x4
	.2byte	0x435
	.4byte	0x14e
	.uleb128 0xb
	.4byte	.LASF11
	.byte	0x4
	.2byte	0x436
	.4byte	0x164
	.byte	0
	.uleb128 0xc
	.ascii	"OUT\000"
	.byte	0x4
	.2byte	0x437
	.4byte	0x73
	.2byte	0x504
	.uleb128 0xd
	.4byte	.LASF12
	.byte	0x4
	.2byte	0x438
	.4byte	0x73
	.2byte	0x508
	.uleb128 0xd
	.4byte	.LASF13
	.byte	0x4
	.2byte	0x439
	.4byte	0x73
	.2byte	0x50c
	.uleb128 0xc
	.ascii	"IN\000"
	.byte	0x4
	.2byte	0x43a
	.4byte	0x78
	.2byte	0x510
	.uleb128 0xc
	.ascii	"DIR\000"
	.byte	0x4
	.2byte	0x43b
	.4byte	0x73
	.2byte	0x514
	.uleb128 0xd
	.4byte	.LASF14
	.byte	0x4
	.2byte	0x43c
	.4byte	0x73
	.2byte	0x518
	.uleb128 0xd
	.4byte	.LASF15
	.byte	0x4
	.2byte	0x43d
	.4byte	0x73
	.2byte	0x51c
	.uleb128 0xd
	.4byte	.LASF16
	.byte	0x4
	.2byte	0x43e
	.4byte	0x17e
	.2byte	0x520
	.uleb128 0xd
	.4byte	.LASF17
	.byte	0x4
	.2byte	0x43f
	.4byte	0xb4
	.2byte	0x700
	.byte	0
	.uleb128 0x8
	.4byte	0x78
	.4byte	0x15f
	.uleb128 0xe
	.4byte	0x92
	.2byte	0x140
	.byte	0
	.uleb128 0x4
	.4byte	0x14e
	.uleb128 0x6
	.4byte	0x15f
	.uleb128 0x8
	.4byte	0x78
	.4byte	0x179
	.uleb128 0x9
	.4byte	0x92
	.byte	0x77
	.byte	0
	.uleb128 0x4
	.4byte	0x169
	.uleb128 0x6
	.4byte	0x179
	.uleb128 0xf
	.4byte	.LASF18
	.byte	0x4
	.2byte	0x440
	.4byte	0xb9
	.uleb128 0x4
	.4byte	0x183
	.uleb128 0x10
	.4byte	.LASF69
	.byte	0x8
	.byte	0x5
	.byte	0x5e
	.4byte	0x1b9
	.uleb128 0x11
	.4byte	.LASF19
	.byte	0x5
	.byte	0x5f
	.4byte	0x61
	.byte	0
	.uleb128 0x11
	.4byte	.LASF20
	.byte	0x5
	.byte	0x60
	.4byte	0x1b9
	.byte	0x4
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF21
	.uleb128 0x12
	.4byte	0x61
	.4byte	0x1d9
	.uleb128 0x13
	.4byte	0x1d9
	.uleb128 0x13
	.4byte	0x7d
	.uleb128 0x13
	.4byte	0x1eb
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x1df
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF22
	.uleb128 0x4
	.4byte	0x1df
	.uleb128 0x14
	.byte	0x4
	.4byte	0x194
	.uleb128 0x12
	.4byte	0x61
	.4byte	0x20f
	.uleb128 0x13
	.4byte	0x20f
	.uleb128 0x13
	.4byte	0x215
	.uleb128 0x13
	.4byte	0x7d
	.uleb128 0x13
	.4byte	0x1eb
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x7d
	.uleb128 0x14
	.byte	0x4
	.4byte	0x1e6
	.uleb128 0x15
	.byte	0x58
	.byte	0x5
	.byte	0x66
	.4byte	0x3a4
	.uleb128 0x11
	.4byte	.LASF23
	.byte	0x5
	.byte	0x68
	.4byte	0x215
	.byte	0
	.uleb128 0x11
	.4byte	.LASF24
	.byte	0x5
	.byte	0x69
	.4byte	0x215
	.byte	0x4
	.uleb128 0x11
	.4byte	.LASF25
	.byte	0x5
	.byte	0x6a
	.4byte	0x215
	.byte	0x8
	.uleb128 0x11
	.4byte	.LASF26
	.byte	0x5
	.byte	0x6c
	.4byte	0x215
	.byte	0xc
	.uleb128 0x11
	.4byte	.LASF27
	.byte	0x5
	.byte	0x6d
	.4byte	0x215
	.byte	0x10
	.uleb128 0x11
	.4byte	.LASF28
	.byte	0x5
	.byte	0x6e
	.4byte	0x215
	.byte	0x14
	.uleb128 0x11
	.4byte	.LASF29
	.byte	0x5
	.byte	0x6f
	.4byte	0x215
	.byte	0x18
	.uleb128 0x11
	.4byte	.LASF30
	.byte	0x5
	.byte	0x70
	.4byte	0x215
	.byte	0x1c
	.uleb128 0x11
	.4byte	.LASF31
	.byte	0x5
	.byte	0x71
	.4byte	0x215
	.byte	0x20
	.uleb128 0x11
	.4byte	.LASF32
	.byte	0x5
	.byte	0x72
	.4byte	0x215
	.byte	0x24
	.uleb128 0x11
	.4byte	.LASF33
	.byte	0x5
	.byte	0x74
	.4byte	0x1df
	.byte	0x28
	.uleb128 0x11
	.4byte	.LASF34
	.byte	0x5
	.byte	0x75
	.4byte	0x1df
	.byte	0x29
	.uleb128 0x11
	.4byte	.LASF35
	.byte	0x5
	.byte	0x76
	.4byte	0x1df
	.byte	0x2a
	.uleb128 0x11
	.4byte	.LASF36
	.byte	0x5
	.byte	0x77
	.4byte	0x1df
	.byte	0x2b
	.uleb128 0x11
	.4byte	.LASF37
	.byte	0x5
	.byte	0x78
	.4byte	0x1df
	.byte	0x2c
	.uleb128 0x11
	.4byte	.LASF38
	.byte	0x5
	.byte	0x79
	.4byte	0x1df
	.byte	0x2d
	.uleb128 0x11
	.4byte	.LASF39
	.byte	0x5
	.byte	0x7a
	.4byte	0x1df
	.byte	0x2e
	.uleb128 0x11
	.4byte	.LASF40
	.byte	0x5
	.byte	0x7b
	.4byte	0x1df
	.byte	0x2f
	.uleb128 0x11
	.4byte	.LASF41
	.byte	0x5
	.byte	0x7c
	.4byte	0x1df
	.byte	0x30
	.uleb128 0x11
	.4byte	.LASF42
	.byte	0x5
	.byte	0x7d
	.4byte	0x1df
	.byte	0x31
	.uleb128 0x11
	.4byte	.LASF43
	.byte	0x5
	.byte	0x7e
	.4byte	0x1df
	.byte	0x32
	.uleb128 0x11
	.4byte	.LASF44
	.byte	0x5
	.byte	0x7f
	.4byte	0x1df
	.byte	0x33
	.uleb128 0x11
	.4byte	.LASF45
	.byte	0x5
	.byte	0x80
	.4byte	0x1df
	.byte	0x34
	.uleb128 0x11
	.4byte	.LASF46
	.byte	0x5
	.byte	0x81
	.4byte	0x1df
	.byte	0x35
	.uleb128 0x11
	.4byte	.LASF47
	.byte	0x5
	.byte	0x86
	.4byte	0x215
	.byte	0x38
	.uleb128 0x11
	.4byte	.LASF48
	.byte	0x5
	.byte	0x87
	.4byte	0x215
	.byte	0x3c
	.uleb128 0x11
	.4byte	.LASF49
	.byte	0x5
	.byte	0x88
	.4byte	0x215
	.byte	0x40
	.uleb128 0x11
	.4byte	.LASF50
	.byte	0x5
	.byte	0x89
	.4byte	0x215
	.byte	0x44
	.uleb128 0x11
	.4byte	.LASF51
	.byte	0x5
	.byte	0x8a
	.4byte	0x215
	.byte	0x48
	.uleb128 0x11
	.4byte	.LASF52
	.byte	0x5
	.byte	0x8b
	.4byte	0x215
	.byte	0x4c
	.uleb128 0x11
	.4byte	.LASF53
	.byte	0x5
	.byte	0x8c
	.4byte	0x215
	.byte	0x50
	.uleb128 0x11
	.4byte	.LASF54
	.byte	0x5
	.byte	0x8d
	.4byte	0x215
	.byte	0x54
	.byte	0
	.uleb128 0x3
	.4byte	.LASF55
	.byte	0x5
	.byte	0x8e
	.4byte	0x21b
	.uleb128 0x4
	.4byte	0x3a4
	.uleb128 0x15
	.byte	0x20
	.byte	0x5
	.byte	0xa4
	.4byte	0x41d
	.uleb128 0x11
	.4byte	.LASF56
	.byte	0x5
	.byte	0xa6
	.4byte	0x431
	.byte	0
	.uleb128 0x11
	.4byte	.LASF57
	.byte	0x5
	.byte	0xa7
	.4byte	0x446
	.byte	0x4
	.uleb128 0x11
	.4byte	.LASF58
	.byte	0x5
	.byte	0xa8
	.4byte	0x446
	.byte	0x8
	.uleb128 0x11
	.4byte	.LASF59
	.byte	0x5
	.byte	0xab
	.4byte	0x460
	.byte	0xc
	.uleb128 0x11
	.4byte	.LASF60
	.byte	0x5
	.byte	0xac
	.4byte	0x475
	.byte	0x10
	.uleb128 0x11
	.4byte	.LASF61
	.byte	0x5
	.byte	0xad
	.4byte	0x475
	.byte	0x14
	.uleb128 0x11
	.4byte	.LASF62
	.byte	0x5
	.byte	0xb0
	.4byte	0x47b
	.byte	0x18
	.uleb128 0x11
	.4byte	.LASF63
	.byte	0x5
	.byte	0xb1
	.4byte	0x481
	.byte	0x1c
	.byte	0
	.uleb128 0x12
	.4byte	0x61
	.4byte	0x431
	.uleb128 0x13
	.4byte	0x61
	.uleb128 0x13
	.4byte	0x61
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x41d
	.uleb128 0x12
	.4byte	0x61
	.4byte	0x446
	.uleb128 0x13
	.4byte	0x61
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x437
	.uleb128 0x12
	.4byte	0x61
	.4byte	0x460
	.uleb128 0x13
	.4byte	0x1b9
	.uleb128 0x13
	.4byte	0x61
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x44c
	.uleb128 0x12
	.4byte	0x1b9
	.4byte	0x475
	.uleb128 0x13
	.4byte	0x1b9
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x466
	.uleb128 0x14
	.byte	0x4
	.4byte	0x1c0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x1f1
	.uleb128 0x3
	.4byte	.LASF64
	.byte	0x5
	.byte	0xb2
	.4byte	0x3b4
	.uleb128 0x4
	.4byte	0x487
	.uleb128 0x15
	.byte	0xc
	.byte	0x5
	.byte	0xb4
	.4byte	0x4c4
	.uleb128 0x11
	.4byte	.LASF65
	.byte	0x5
	.byte	0xb5
	.4byte	0x215
	.byte	0
	.uleb128 0x11
	.4byte	.LASF66
	.byte	0x5
	.byte	0xb6
	.4byte	0x4c4
	.byte	0x4
	.uleb128 0x11
	.4byte	.LASF67
	.byte	0x5
	.byte	0xb7
	.4byte	0x4ca
	.byte	0x8
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x3af
	.uleb128 0x14
	.byte	0x4
	.4byte	0x492
	.uleb128 0x3
	.4byte	.LASF68
	.byte	0x5
	.byte	0xb8
	.4byte	0x497
	.uleb128 0x4
	.4byte	0x4d0
	.uleb128 0x10
	.4byte	.LASF70
	.byte	0x14
	.byte	0x5
	.byte	0xbc
	.4byte	0x4f9
	.uleb128 0x11
	.4byte	.LASF71
	.byte	0x5
	.byte	0xbd
	.4byte	0x4f9
	.byte	0
	.byte	0
	.uleb128 0x8
	.4byte	0x509
	.4byte	0x509
	.uleb128 0x9
	.4byte	0x92
	.byte	0x4
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x4db
	.uleb128 0x7
	.4byte	.LASF73
	.byte	0x5
	.byte	0xe6
	.4byte	0x4e0
	.uleb128 0x7
	.4byte	.LASF74
	.byte	0x5
	.byte	0xed
	.4byte	0x4db
	.uleb128 0x7
	.4byte	.LASF75
	.byte	0x5
	.byte	0xf0
	.4byte	0x492
	.uleb128 0x7
	.4byte	.LASF76
	.byte	0x5
	.byte	0xf1
	.4byte	0x492
	.uleb128 0x8
	.4byte	0x43
	.4byte	0x54b
	.uleb128 0x9
	.4byte	0x92
	.byte	0x7f
	.byte	0
	.uleb128 0x4
	.4byte	0x53b
	.uleb128 0x7
	.4byte	.LASF77
	.byte	0x5
	.byte	0xf3
	.4byte	0x54b
	.uleb128 0x8
	.4byte	0x1e6
	.4byte	0x566
	.uleb128 0x16
	.byte	0
	.uleb128 0x4
	.4byte	0x55b
	.uleb128 0x7
	.4byte	.LASF78
	.byte	0x5
	.byte	0xf5
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF79
	.byte	0x5
	.byte	0xf6
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF80
	.byte	0x5
	.byte	0xf7
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF81
	.byte	0x5
	.byte	0xf8
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF82
	.byte	0x5
	.byte	0xfa
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF83
	.byte	0x5
	.byte	0xfb
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF84
	.byte	0x5
	.byte	0xfc
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF85
	.byte	0x5
	.byte	0xfd
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF86
	.byte	0x5
	.byte	0xfe
	.4byte	0x566
	.uleb128 0x7
	.4byte	.LASF87
	.byte	0x5
	.byte	0xff
	.4byte	0x566
	.uleb128 0x12
	.4byte	0x61
	.4byte	0x5e8
	.uleb128 0x13
	.4byte	0x5e8
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x5f3
	.uleb128 0x17
	.4byte	.LASF97
	.uleb128 0x4
	.4byte	0x5ee
	.uleb128 0x18
	.4byte	.LASF88
	.byte	0x5
	.2byte	0x115
	.4byte	0x604
	.uleb128 0x14
	.byte	0x4
	.4byte	0x5d9
	.uleb128 0x12
	.4byte	0x61
	.4byte	0x619
	.uleb128 0x13
	.4byte	0x619
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x5ee
	.uleb128 0x18
	.4byte	.LASF89
	.byte	0x5
	.2byte	0x116
	.4byte	0x62b
	.uleb128 0x14
	.byte	0x4
	.4byte	0x60a
	.uleb128 0xf
	.4byte	.LASF90
	.byte	0x5
	.2byte	0x12d
	.4byte	0x63d
	.uleb128 0x14
	.byte	0x4
	.4byte	0x643
	.uleb128 0x12
	.4byte	0x215
	.4byte	0x652
	.uleb128 0x13
	.4byte	0x61
	.byte	0
	.uleb128 0x19
	.4byte	.LASF91
	.byte	0x8
	.byte	0x5
	.2byte	0x12f
	.4byte	0x67a
	.uleb128 0xb
	.4byte	.LASF92
	.byte	0x5
	.2byte	0x131
	.4byte	0x631
	.byte	0
	.uleb128 0xb
	.4byte	.LASF93
	.byte	0x5
	.2byte	0x132
	.4byte	0x67a
	.byte	0x4
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x652
	.uleb128 0xf
	.4byte	.LASF94
	.byte	0x5
	.2byte	0x133
	.4byte	0x652
	.uleb128 0x18
	.4byte	.LASF95
	.byte	0x5
	.2byte	0x137
	.4byte	0x698
	.uleb128 0x14
	.byte	0x4
	.4byte	0x680
	.uleb128 0xf
	.4byte	.LASF96
	.byte	0x7
	.2byte	0x2f2
	.4byte	0x6aa
	.uleb128 0x17
	.4byte	.LASF98
	.uleb128 0x18
	.4byte	.LASF99
	.byte	0x7
	.2byte	0x2f6
	.4byte	0x6bb
	.uleb128 0x14
	.byte	0x4
	.4byte	0x69e
	.uleb128 0x18
	.4byte	.LASF100
	.byte	0x7
	.2byte	0x2f7
	.4byte	0x6bb
	.uleb128 0x18
	.4byte	.LASF101
	.byte	0x7
	.2byte	0x2f8
	.4byte	0x6bb
	.uleb128 0x8
	.4byte	0x215
	.4byte	0x6e9
	.uleb128 0x9
	.4byte	0x92
	.byte	0x11
	.byte	0
	.uleb128 0x7
	.4byte	.LASF102
	.byte	0x8
	.byte	0x9c
	.4byte	0x6d9
	.uleb128 0x8
	.4byte	0x215
	.4byte	0x704
	.uleb128 0x9
	.4byte	0x92
	.byte	0x8
	.byte	0
	.uleb128 0x7
	.4byte	.LASF103
	.byte	0x8
	.byte	0x9d
	.4byte	0x6f4
	.uleb128 0x8
	.4byte	0x215
	.4byte	0x71f
	.uleb128 0x9
	.4byte	0x92
	.byte	0x2
	.byte	0
	.uleb128 0x7
	.4byte	.LASF104
	.byte	0x8
	.byte	0x9e
	.4byte	0x70f
	.uleb128 0x1a
	.byte	0x1
	.4byte	0x3c
	.byte	0x1
	.byte	0x50
	.4byte	0x743
	.uleb128 0x1b
	.4byte	.LASF105
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF106
	.byte	0x1
	.byte	0
	.uleb128 0x3
	.4byte	.LASF107
	.byte	0x1
	.byte	0x53
	.4byte	0x72a
	.uleb128 0x1a
	.byte	0x1
	.4byte	0x3c
	.byte	0x1
	.byte	0x59
	.4byte	0x767
	.uleb128 0x1b
	.4byte	.LASF108
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF109
	.byte	0x1
	.byte	0
	.uleb128 0x3
	.4byte	.LASF110
	.byte	0x1
	.byte	0x5c
	.4byte	0x74e
	.uleb128 0x1a
	.byte	0x1
	.4byte	0x3c
	.byte	0x1
	.byte	0x62
	.4byte	0x791
	.uleb128 0x1b
	.4byte	.LASF111
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF112
	.byte	0x1
	.uleb128 0x1b
	.4byte	.LASF113
	.byte	0x3
	.byte	0
	.uleb128 0x3
	.4byte	.LASF114
	.byte	0x1
	.byte	0x66
	.4byte	0x772
	.uleb128 0x1a
	.byte	0x1
	.4byte	0x3c
	.byte	0x1
	.byte	0x6c
	.4byte	0x7d9
	.uleb128 0x1b
	.4byte	.LASF115
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF116
	.byte	0x1
	.uleb128 0x1b
	.4byte	.LASF117
	.byte	0x2
	.uleb128 0x1b
	.4byte	.LASF118
	.byte	0x3
	.uleb128 0x1b
	.4byte	.LASF119
	.byte	0x4
	.uleb128 0x1b
	.4byte	.LASF120
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF121
	.byte	0x6
	.uleb128 0x1b
	.4byte	.LASF122
	.byte	0x7
	.byte	0
	.uleb128 0x3
	.4byte	.LASF123
	.byte	0x1
	.byte	0x75
	.4byte	0x79c
	.uleb128 0x1a
	.byte	0x1
	.4byte	0x3c
	.byte	0x1
	.byte	0x7b
	.4byte	0x803
	.uleb128 0x1b
	.4byte	.LASF124
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF125
	.byte	0x3
	.uleb128 0x1b
	.4byte	.LASF126
	.byte	0x2
	.byte	0
	.uleb128 0x3
	.4byte	.LASF127
	.byte	0x1
	.byte	0x7f
	.4byte	0x7e4
	.uleb128 0x8
	.4byte	0x37
	.4byte	0x81e
	.uleb128 0x9
	.4byte	0x92
	.byte	0x3
	.byte	0
	.uleb128 0x4
	.4byte	0x80e
	.uleb128 0x1c
	.4byte	.LASF128
	.byte	0x2
	.byte	0x2d
	.4byte	0x81e
	.uleb128 0x5
	.byte	0x3
	.4byte	m_board_led_list
	.uleb128 0x1c
	.4byte	.LASF129
	.byte	0x2
	.byte	0x31
	.4byte	0x81e
	.uleb128 0x5
	.byte	0x3
	.4byte	m_board_btn_list
	.uleb128 0x1d
	.4byte	.LASF130
	.byte	0x2
	.byte	0xa0
	.4byte	0x68
	.4byte	.LFB78
	.4byte	.LFE78-.LFB78
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x86d
	.uleb128 0x1e
	.4byte	.LASF132
	.byte	0x2
	.byte	0xa0
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF131
	.byte	0x2
	.byte	0x91
	.4byte	0x68
	.4byte	.LFB77
	.4byte	.LFE77-.LFB77
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x8af
	.uleb128 0x1e
	.4byte	.LASF133
	.byte	0x2
	.byte	0x91
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1f
	.ascii	"i\000"
	.byte	0x2
	.byte	0x93
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x1f
	.ascii	"ret\000"
	.byte	0x2
	.byte	0x94
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0
	.uleb128 0x20
	.4byte	.LASF140
	.byte	0x2
	.byte	0x88
	.4byte	.LFB76
	.4byte	.LFE76-.LFB76
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x8d1
	.uleb128 0x1f
	.ascii	"i\000"
	.byte	0x2
	.byte	0x8a
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x21
	.4byte	.LASF134
	.byte	0x2
	.byte	0x81
	.4byte	0x907
	.4byte	.LFB75
	.4byte	.LFE75-.LFB75
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x907
	.uleb128 0x1e
	.4byte	.LASF132
	.byte	0x2
	.byte	0x81
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1c
	.4byte	.LASF135
	.byte	0x2
	.byte	0x84
	.4byte	0x907
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.4byte	.LASF136
	.uleb128 0x1d
	.4byte	.LASF137
	.byte	0x2
	.byte	0x70
	.4byte	0x68
	.4byte	.LFB74
	.4byte	.LFE74-.LFB74
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x950
	.uleb128 0x1e
	.4byte	.LASF133
	.byte	0x2
	.byte	0x70
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1f
	.ascii	"ret\000"
	.byte	0x2
	.byte	0x72
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x1f
	.ascii	"i\000"
	.byte	0x2
	.byte	0x73
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF138
	.byte	0x2
	.byte	0x6a
	.4byte	0x68
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x978
	.uleb128 0x1e
	.4byte	.LASF139
	.byte	0x2
	.byte	0x6a
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x20
	.4byte	.LASF141
	.byte	0x2
	.byte	0x60
	.4byte	.LFB72
	.4byte	.LFE72-.LFB72
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x99a
	.uleb128 0x1f
	.ascii	"i\000"
	.byte	0x2
	.byte	0x62
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x20
	.4byte	.LASF142
	.byte	0x2
	.byte	0x5a
	.4byte	.LFB71
	.4byte	.LFE71-.LFB71
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x9be
	.uleb128 0x1e
	.4byte	.LASF139
	.byte	0x2
	.byte	0x5a
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x20
	.4byte	.LASF143
	.byte	0x2
	.byte	0x51
	.4byte	.LFB70
	.4byte	.LFE70-.LFB70
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x9e0
	.uleb128 0x1f
	.ascii	"i\000"
	.byte	0x2
	.byte	0x53
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x20
	.4byte	.LASF144
	.byte	0x2
	.byte	0x48
	.4byte	.LFB69
	.4byte	.LFE69-.LFB69
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xa02
	.uleb128 0x1f
	.ascii	"i\000"
	.byte	0x2
	.byte	0x4a
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x20
	.4byte	.LASF145
	.byte	0x2
	.byte	0x42
	.4byte	.LFB68
	.4byte	.LFE68-.LFB68
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xa26
	.uleb128 0x1e
	.4byte	.LASF139
	.byte	0x2
	.byte	0x42
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x20
	.4byte	.LASF146
	.byte	0x2
	.byte	0x3c
	.4byte	.LFB67
	.4byte	.LFE67-.LFB67
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xa4a
	.uleb128 0x1e
	.4byte	.LASF139
	.byte	0x2
	.byte	0x3c
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x21
	.4byte	.LASF147
	.byte	0x2
	.byte	0x35
	.4byte	0x907
	.4byte	.LFB66
	.4byte	.LFE66-.LFB66
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xa80
	.uleb128 0x1e
	.4byte	.LASF139
	.byte	0x2
	.byte	0x35
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1c
	.4byte	.LASF135
	.byte	0x2
	.byte	0x38
	.4byte	0x907
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x22
	.4byte	.LASF150
	.byte	0x1
	.2byte	0x2de
	.4byte	.LFB64
	.4byte	.LFE64-.LFB64
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xab5
	.uleb128 0x23
	.4byte	.LASF148
	.byte	0x1
	.2byte	0x2de
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x23
	.4byte	.LASF149
	.byte	0x1
	.2byte	0x2de
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x183
	.uleb128 0x22
	.4byte	.LASF151
	.byte	0x1
	.2byte	0x2d8
	.4byte	.LFB63
	.4byte	.LFE63-.LFB63
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xaf0
	.uleb128 0x23
	.4byte	.LASF148
	.byte	0x1
	.2byte	0x2d8
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x23
	.4byte	.LASF152
	.byte	0x1
	.2byte	0x2d8
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0
	.uleb128 0x24
	.4byte	.LASF153
	.byte	0x1
	.2byte	0x2cc
	.4byte	0x68
	.4byte	.LFB61
	.4byte	.LFE61-.LFB61
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb1a
	.uleb128 0x23
	.4byte	.LASF148
	.byte	0x1
	.2byte	0x2cc
	.4byte	0xb1a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x18f
	.uleb128 0x24
	.4byte	.LASF154
	.byte	0x1
	.2byte	0x2c6
	.4byte	0x68
	.4byte	.LFB60
	.4byte	.LFE60-.LFB60
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb4a
	.uleb128 0x23
	.4byte	.LASF148
	.byte	0x1
	.2byte	0x2c6
	.4byte	0xb1a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x25
	.4byte	.LASF155
	.byte	0x1
	.2byte	0x29d
	.4byte	0x68
	.4byte	.LFB54
	.4byte	.LFE54-.LFB54
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb83
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x29d
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x26
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x29f
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x25
	.4byte	.LASF156
	.byte	0x1
	.2byte	0x295
	.4byte	0x68
	.4byte	.LFB53
	.4byte	.LFE53-.LFB53
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xbbc
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x295
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x26
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x297
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x27
	.4byte	.LASF157
	.byte	0x1
	.2byte	0x288
	.4byte	.LFB52
	.4byte	.LFE52-.LFB52
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xbf1
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x288
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x23
	.4byte	.LASF158
	.byte	0x1
	.2byte	0x288
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x27
	.4byte	.LASF159
	.byte	0x1
	.2byte	0x27e
	.4byte	.LFB51
	.4byte	.LFE51-.LFB51
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc35
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x27e
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x26
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x280
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x28
	.4byte	.LASF160
	.byte	0x1
	.2byte	0x281
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x27
	.4byte	.LASF161
	.byte	0x1
	.2byte	0x276
	.4byte	.LFB50
	.4byte	.LFE50-.LFB50
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc6a
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x276
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x26
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x278
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x27
	.4byte	.LASF162
	.byte	0x1
	.2byte	0x26e
	.4byte	.LFB49
	.4byte	.LFE49-.LFB49
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc9f
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x26e
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x26
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x270
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x27
	.4byte	.LASF163
	.byte	0x1
	.2byte	0x216
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xcd4
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x216
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x23
	.4byte	.LASF164
	.byte	0x1
	.2byte	0x216
	.4byte	0x791
	.uleb128 0x2
	.byte	0x91
	.sleb128 -13
	.byte	0
	.uleb128 0x27
	.4byte	.LASF165
	.byte	0x1
	.2byte	0x20a
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xcfa
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x20a
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x27
	.4byte	.LASF166
	.byte	0x1
	.2byte	0x1f8
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xd7a
	.uleb128 0x23
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x1f9
	.4byte	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x29
	.ascii	"dir\000"
	.byte	0x1
	.2byte	0x1fa
	.4byte	0x743
	.uleb128 0x2
	.byte	0x91
	.sleb128 -21
	.uleb128 0x23
	.4byte	.LASF167
	.byte	0x1
	.2byte	0x1fb
	.4byte	0x767
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x23
	.4byte	.LASF168
	.byte	0x1
	.2byte	0x1fc
	.4byte	0x791
	.uleb128 0x2
	.byte	0x91
	.sleb128 -23
	.uleb128 0x23
	.4byte	.LASF169
	.byte	0x1
	.2byte	0x1fd
	.4byte	0x7d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x23
	.4byte	.LASF170
	.byte	0x1
	.2byte	0x1fe
	.4byte	0x803
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x26
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x200
	.4byte	0xab5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x24
	.4byte	.LASF171
	.byte	0x1
	.2byte	0x1ce
	.4byte	0xab5
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xda4
	.uleb128 0x23
	.4byte	.LASF172
	.byte	0x1
	.2byte	0x1ce
	.4byte	0xda4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x14
	.byte	0x4
	.4byte	0x68
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.uleb128 0x2134
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_pubnames,"",%progbits
	.4byte	0x4a6
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0xdab
	.4byte	0x736
	.ascii	"NRF_GPIO_PIN_DIR_INPUT\000"
	.4byte	0x73c
	.ascii	"NRF_GPIO_PIN_DIR_OUTPUT\000"
	.4byte	0x75a
	.ascii	"NRF_GPIO_PIN_INPUT_CONNECT\000"
	.4byte	0x760
	.ascii	"NRF_GPIO_PIN_INPUT_DISCONNECT\000"
	.4byte	0x77e
	.ascii	"NRF_GPIO_PIN_NOPULL\000"
	.4byte	0x784
	.ascii	"NRF_GPIO_PIN_PULLDOWN\000"
	.4byte	0x78a
	.ascii	"NRF_GPIO_PIN_PULLUP\000"
	.4byte	0x7a8
	.ascii	"NRF_GPIO_PIN_S0S1\000"
	.4byte	0x7ae
	.ascii	"NRF_GPIO_PIN_H0S1\000"
	.4byte	0x7b4
	.ascii	"NRF_GPIO_PIN_S0H1\000"
	.4byte	0x7ba
	.ascii	"NRF_GPIO_PIN_H0H1\000"
	.4byte	0x7c0
	.ascii	"NRF_GPIO_PIN_D0S1\000"
	.4byte	0x7c6
	.ascii	"NRF_GPIO_PIN_D0H1\000"
	.4byte	0x7cc
	.ascii	"NRF_GPIO_PIN_S0D1\000"
	.4byte	0x7d2
	.ascii	"NRF_GPIO_PIN_H0D1\000"
	.4byte	0x7f0
	.ascii	"NRF_GPIO_PIN_NOSENSE\000"
	.4byte	0x7f6
	.ascii	"NRF_GPIO_PIN_SENSE_LOW\000"
	.4byte	0x7fc
	.ascii	"NRF_GPIO_PIN_SENSE_HIGH\000"
	.4byte	0x823
	.ascii	"m_board_led_list\000"
	.4byte	0x834
	.ascii	"m_board_btn_list\000"
	.4byte	0x845
	.ascii	"bsp_board_button_idx_to_pin\000"
	.4byte	0x86d
	.ascii	"bsp_board_pin_to_button_idx\000"
	.4byte	0x8af
	.ascii	"bsp_board_buttons_init\000"
	.4byte	0x8d1
	.ascii	"bsp_board_button_state_get\000"
	.4byte	0x90e
	.ascii	"bsp_board_pin_to_led_idx\000"
	.4byte	0x950
	.ascii	"bsp_board_led_idx_to_pin\000"
	.4byte	0x978
	.ascii	"bsp_board_leds_init\000"
	.4byte	0x99a
	.ascii	"bsp_board_led_invert\000"
	.4byte	0x9be
	.ascii	"bsp_board_leds_on\000"
	.4byte	0x9e0
	.ascii	"bsp_board_leds_off\000"
	.4byte	0xa02
	.ascii	"bsp_board_led_off\000"
	.4byte	0xa26
	.ascii	"bsp_board_led_on\000"
	.4byte	0xa4a
	.ascii	"bsp_board_led_state_get\000"
	.4byte	0xa80
	.ascii	"nrf_gpio_port_out_clear\000"
	.4byte	0xabb
	.ascii	"nrf_gpio_port_out_set\000"
	.4byte	0xaf0
	.ascii	"nrf_gpio_port_out_read\000"
	.4byte	0xb20
	.ascii	"nrf_gpio_port_in_read\000"
	.4byte	0xb4a
	.ascii	"nrf_gpio_pin_out_read\000"
	.4byte	0xb83
	.ascii	"nrf_gpio_pin_read\000"
	.4byte	0xbbc
	.ascii	"nrf_gpio_pin_write\000"
	.4byte	0xbf1
	.ascii	"nrf_gpio_pin_toggle\000"
	.4byte	0xc35
	.ascii	"nrf_gpio_pin_clear\000"
	.4byte	0xc6a
	.ascii	"nrf_gpio_pin_set\000"
	.4byte	0xc9f
	.ascii	"nrf_gpio_cfg_input\000"
	.4byte	0xcd4
	.ascii	"nrf_gpio_cfg_output\000"
	.4byte	0xcfa
	.ascii	"nrf_gpio_cfg\000"
	.4byte	0xd7a
	.ascii	"nrf_gpio_pin_port_decode\000"
	.4byte	0
	.section	.debug_pubtypes,"",%progbits
	.4byte	0x239
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0xdab
	.4byte	0x25
	.ascii	"signed char\000"
	.4byte	0x3c
	.ascii	"unsigned char\000"
	.4byte	0x2c
	.ascii	"uint8_t\000"
	.4byte	0x48
	.ascii	"short int\000"
	.4byte	0x5a
	.ascii	"short unsigned int\000"
	.4byte	0x4f
	.ascii	"uint16_t\000"
	.4byte	0x61
	.ascii	"int\000"
	.4byte	0x7d
	.ascii	"unsigned int\000"
	.4byte	0x68
	.ascii	"uint32_t\000"
	.4byte	0x84
	.ascii	"long long int\000"
	.4byte	0x8b
	.ascii	"long long unsigned int\000"
	.4byte	0x92
	.ascii	"sizetype\000"
	.4byte	0x183
	.ascii	"NRF_GPIO_Type\000"
	.4byte	0x1b9
	.ascii	"long int\000"
	.4byte	0x194
	.ascii	"__mbstate_s\000"
	.4byte	0x1df
	.ascii	"char\000"
	.4byte	0x3a4
	.ascii	"__RAL_locale_data_t\000"
	.4byte	0x487
	.ascii	"__RAL_locale_codeset_t\000"
	.4byte	0x4d0
	.ascii	"__RAL_locale_t\000"
	.4byte	0x4e0
	.ascii	"__locale_s\000"
	.4byte	0x631
	.ascii	"__RAL_error_decoder_fn_t\000"
	.4byte	0x652
	.ascii	"__RAL_error_decoder_s\000"
	.4byte	0x680
	.ascii	"__RAL_error_decoder_t\000"
	.4byte	0x69e
	.ascii	"FILE\000"
	.4byte	0x743
	.ascii	"nrf_gpio_pin_dir_t\000"
	.4byte	0x767
	.ascii	"nrf_gpio_pin_input_t\000"
	.4byte	0x791
	.ascii	"nrf_gpio_pin_pull_t\000"
	.4byte	0x7d9
	.ascii	"nrf_gpio_pin_drive_t\000"
	.4byte	0x803
	.ascii	"nrf_gpio_pin_sense_t\000"
	.4byte	0x907
	.ascii	"_Bool\000"
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0xec
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.4byte	.LFB49
	.4byte	.LFE49-.LFB49
	.4byte	.LFB50
	.4byte	.LFE50-.LFB50
	.4byte	.LFB51
	.4byte	.LFE51-.LFB51
	.4byte	.LFB52
	.4byte	.LFE52-.LFB52
	.4byte	.LFB53
	.4byte	.LFE53-.LFB53
	.4byte	.LFB54
	.4byte	.LFE54-.LFB54
	.4byte	.LFB60
	.4byte	.LFE60-.LFB60
	.4byte	.LFB61
	.4byte	.LFE61-.LFB61
	.4byte	.LFB63
	.4byte	.LFE63-.LFB63
	.4byte	.LFB64
	.4byte	.LFE64-.LFB64
	.4byte	.LFB66
	.4byte	.LFE66-.LFB66
	.4byte	.LFB67
	.4byte	.LFE67-.LFB67
	.4byte	.LFB68
	.4byte	.LFE68-.LFB68
	.4byte	.LFB69
	.4byte	.LFE69-.LFB69
	.4byte	.LFB70
	.4byte	.LFE70-.LFB70
	.4byte	.LFB71
	.4byte	.LFE71-.LFB71
	.4byte	.LFB72
	.4byte	.LFE72-.LFB72
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.4byte	.LFB74
	.4byte	.LFE74-.LFB74
	.4byte	.LFB75
	.4byte	.LFE75-.LFB75
	.4byte	.LFB76
	.4byte	.LFE76-.LFB76
	.4byte	.LFB77
	.4byte	.LFE77-.LFB77
	.4byte	.LFB78
	.4byte	.LFE78-.LFB78
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB37
	.4byte	.LFE37
	.4byte	.LFB40
	.4byte	.LFE40
	.4byte	.LFB41
	.4byte	.LFE41
	.4byte	.LFB42
	.4byte	.LFE42
	.4byte	.LFB49
	.4byte	.LFE49
	.4byte	.LFB50
	.4byte	.LFE50
	.4byte	.LFB51
	.4byte	.LFE51
	.4byte	.LFB52
	.4byte	.LFE52
	.4byte	.LFB53
	.4byte	.LFE53
	.4byte	.LFB54
	.4byte	.LFE54
	.4byte	.LFB60
	.4byte	.LFE60
	.4byte	.LFB61
	.4byte	.LFE61
	.4byte	.LFB63
	.4byte	.LFE63
	.4byte	.LFB64
	.4byte	.LFE64
	.4byte	.LFB66
	.4byte	.LFE66
	.4byte	.LFB67
	.4byte	.LFE67
	.4byte	.LFB68
	.4byte	.LFE68
	.4byte	.LFB69
	.4byte	.LFE69
	.4byte	.LFB70
	.4byte	.LFE70
	.4byte	.LFB71
	.4byte	.LFE71
	.4byte	.LFB72
	.4byte	.LFE72
	.4byte	.LFB73
	.4byte	.LFE73
	.4byte	.LFB74
	.4byte	.LFE74
	.4byte	.LFB75
	.4byte	.LFE75
	.4byte	.LFB76
	.4byte	.LFE76
	.4byte	.LFB77
	.4byte	.LFE77
	.4byte	.LFB78
	.4byte	.LFE78
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF155:
	.ascii	"nrf_gpio_pin_out_read\000"
.LASF72:
	.ascii	"SystemCoreClock\000"
.LASF166:
	.ascii	"nrf_gpio_cfg\000"
.LASF167:
	.ascii	"input\000"
.LASF57:
	.ascii	"__toupper\000"
.LASF101:
	.ascii	"stderr\000"
.LASF165:
	.ascii	"nrf_gpio_cfg_output\000"
.LASF164:
	.ascii	"pull_config\000"
.LASF119:
	.ascii	"NRF_GPIO_PIN_D0S1\000"
.LASF129:
	.ascii	"m_board_btn_list\000"
.LASF7:
	.ascii	"unsigned int\000"
.LASF93:
	.ascii	"next\000"
.LASF146:
	.ascii	"bsp_board_led_on\000"
.LASF78:
	.ascii	"__RAL_c_locale_day_names\000"
.LASF50:
	.ascii	"abbrev_month_names\000"
.LASF14:
	.ascii	"DIRSET\000"
.LASF53:
	.ascii	"time_format\000"
.LASF60:
	.ascii	"__towupper\000"
.LASF124:
	.ascii	"NRF_GPIO_PIN_NOSENSE\000"
.LASF28:
	.ascii	"mon_decimal_point\000"
.LASF102:
	.ascii	"m_sdk_errors_name\000"
.LASF81:
	.ascii	"__RAL_c_locale_abbrev_month_names\000"
.LASF172:
	.ascii	"p_pin\000"
.LASF112:
	.ascii	"NRF_GPIO_PIN_PULLDOWN\000"
.LASF133:
	.ascii	"pin_number\000"
.LASF23:
	.ascii	"decimal_point\000"
.LASF143:
	.ascii	"bsp_board_leds_on\000"
.LASF38:
	.ascii	"n_sep_by_space\000"
.LASF139:
	.ascii	"led_idx\000"
.LASF71:
	.ascii	"__category\000"
.LASF173:
	.ascii	"GNU C99 6.3.1 20170215 (release) [ARM/embedded-6-br"
	.ascii	"anch revision 245512] -fmessage-length=0 -mtp=soft "
	.ascii	"-mcpu=cortex-m0 -mlittle-endian -mfloat-abi=soft -m"
	.ascii	"thumb -g2 -gpubnames -std=gnu99 -fomit-frame-pointe"
	.ascii	"r -fno-dwarf2-cfi-asm -fno-builtin -ffunction-secti"
	.ascii	"ons -fdata-sections -fshort-enums -fno-common\000"
.LASF6:
	.ascii	"uint32_t\000"
.LASF59:
	.ascii	"__iswctype\000"
.LASF36:
	.ascii	"p_sep_by_space\000"
.LASF100:
	.ascii	"stdout\000"
.LASF131:
	.ascii	"bsp_board_pin_to_button_idx\000"
.LASF15:
	.ascii	"DIRCLR\000"
.LASF55:
	.ascii	"__RAL_locale_data_t\000"
.LASF110:
	.ascii	"nrf_gpio_pin_input_t\000"
.LASF86:
	.ascii	"__RAL_data_utf8_minus\000"
.LASF83:
	.ascii	"__RAL_data_utf8_comma\000"
.LASF9:
	.ascii	"long long unsigned int\000"
.LASF88:
	.ascii	"__user_set_time_of_day\000"
.LASF46:
	.ascii	"int_n_sign_posn\000"
.LASF103:
	.ascii	"m_sdk_errors_name_common\000"
.LASF95:
	.ascii	"__RAL_error_decoder_head\000"
.LASF134:
	.ascii	"bsp_board_button_state_get\000"
.LASF128:
	.ascii	"m_board_led_list\000"
.LASF113:
	.ascii	"NRF_GPIO_PIN_PULLUP\000"
.LASF158:
	.ascii	"value\000"
.LASF97:
	.ascii	"timeval\000"
.LASF20:
	.ascii	"__wchar\000"
.LASF170:
	.ascii	"sense\000"
.LASF39:
	.ascii	"p_sign_posn\000"
.LASF135:
	.ascii	"pin_set\000"
.LASF156:
	.ascii	"nrf_gpio_pin_read\000"
.LASF41:
	.ascii	"int_p_cs_precedes\000"
.LASF98:
	.ascii	"__RAL_FILE\000"
.LASF137:
	.ascii	"bsp_board_pin_to_led_idx\000"
.LASF120:
	.ascii	"NRF_GPIO_PIN_D0H1\000"
.LASF99:
	.ascii	"stdin\000"
.LASF161:
	.ascii	"nrf_gpio_pin_clear\000"
.LASF33:
	.ascii	"int_frac_digits\000"
.LASF169:
	.ascii	"drive\000"
.LASF42:
	.ascii	"int_n_cs_precedes\000"
.LASF116:
	.ascii	"NRF_GPIO_PIN_H0S1\000"
.LASF123:
	.ascii	"nrf_gpio_pin_drive_t\000"
.LASF32:
	.ascii	"negative_sign\000"
.LASF122:
	.ascii	"NRF_GPIO_PIN_H0D1\000"
.LASF25:
	.ascii	"grouping\000"
.LASF22:
	.ascii	"char\000"
.LASF105:
	.ascii	"NRF_GPIO_PIN_DIR_INPUT\000"
.LASF68:
	.ascii	"__RAL_locale_t\000"
.LASF87:
	.ascii	"__RAL_data_empty_string\000"
.LASF61:
	.ascii	"__towlower\000"
.LASF66:
	.ascii	"data\000"
.LASF3:
	.ascii	"uint8_t\000"
.LASF130:
	.ascii	"bsp_board_button_idx_to_pin\000"
.LASF144:
	.ascii	"bsp_board_leds_off\000"
.LASF140:
	.ascii	"bsp_board_buttons_init\000"
.LASF114:
	.ascii	"nrf_gpio_pin_pull_t\000"
.LASF160:
	.ascii	"pins_state\000"
.LASF8:
	.ascii	"long long int\000"
.LASF111:
	.ascii	"NRF_GPIO_PIN_NOPULL\000"
.LASF51:
	.ascii	"am_pm_indicator\000"
.LASF147:
	.ascii	"bsp_board_led_state_get\000"
.LASF30:
	.ascii	"mon_grouping\000"
.LASF107:
	.ascii	"nrf_gpio_pin_dir_t\000"
.LASF149:
	.ascii	"clr_mask\000"
.LASF162:
	.ascii	"nrf_gpio_pin_set\000"
.LASF106:
	.ascii	"NRF_GPIO_PIN_DIR_OUTPUT\000"
.LASF48:
	.ascii	"abbrev_day_names\000"
.LASF145:
	.ascii	"bsp_board_led_off\000"
.LASF90:
	.ascii	"__RAL_error_decoder_fn_t\000"
.LASF47:
	.ascii	"day_names\000"
.LASF77:
	.ascii	"__RAL_ascii_ctype_map\000"
.LASF54:
	.ascii	"date_time_format\000"
.LASF63:
	.ascii	"__mbtowc\000"
.LASF163:
	.ascii	"nrf_gpio_cfg_input\000"
.LASF69:
	.ascii	"__mbstate_s\000"
.LASF174:
	.ascii	"/Users/jens/build/nrf/nRF5_SDK_12.3.0/components/bo"
	.ascii	"ards/boards.c\000"
.LASF175:
	.ascii	"/Users/jens/build/nrf/rcqr01/ses_proj\000"
.LASF153:
	.ascii	"nrf_gpio_port_out_read\000"
.LASF152:
	.ascii	"set_mask\000"
.LASF75:
	.ascii	"__RAL_codeset_ascii\000"
.LASF118:
	.ascii	"NRF_GPIO_PIN_H0H1\000"
.LASF64:
	.ascii	"__RAL_locale_codeset_t\000"
.LASF67:
	.ascii	"codeset\000"
.LASF17:
	.ascii	"PIN_CNF\000"
.LASF126:
	.ascii	"NRF_GPIO_PIN_SENSE_HIGH\000"
.LASF11:
	.ascii	"RESERVED0\000"
.LASF16:
	.ascii	"RESERVED1\000"
.LASF12:
	.ascii	"OUTSET\000"
.LASF148:
	.ascii	"p_reg\000"
.LASF2:
	.ascii	"short int\000"
.LASF92:
	.ascii	"decode\000"
.LASF62:
	.ascii	"__wctomb\000"
.LASF26:
	.ascii	"int_curr_symbol\000"
.LASF21:
	.ascii	"long int\000"
.LASF34:
	.ascii	"frac_digits\000"
.LASF141:
	.ascii	"bsp_board_leds_init\000"
.LASF91:
	.ascii	"__RAL_error_decoder_s\000"
.LASF40:
	.ascii	"n_sign_posn\000"
.LASF115:
	.ascii	"NRF_GPIO_PIN_S0S1\000"
.LASF44:
	.ascii	"int_n_sep_by_space\000"
.LASF121:
	.ascii	"NRF_GPIO_PIN_S0D1\000"
.LASF76:
	.ascii	"__RAL_codeset_utf8\000"
.LASF31:
	.ascii	"positive_sign\000"
.LASF43:
	.ascii	"int_p_sep_by_space\000"
.LASF65:
	.ascii	"name\000"
.LASF82:
	.ascii	"__RAL_data_utf8_period\000"
.LASF13:
	.ascii	"OUTCLR\000"
.LASF168:
	.ascii	"pull\000"
.LASF10:
	.ascii	"sizetype\000"
.LASF73:
	.ascii	"__RAL_global_locale\000"
.LASF79:
	.ascii	"__RAL_c_locale_abbrev_day_names\000"
.LASF109:
	.ascii	"NRF_GPIO_PIN_INPUT_DISCONNECT\000"
.LASF154:
	.ascii	"nrf_gpio_port_in_read\000"
.LASF29:
	.ascii	"mon_thousands_sep\000"
.LASF132:
	.ascii	"button_idx\000"
.LASF171:
	.ascii	"nrf_gpio_pin_port_decode\000"
.LASF4:
	.ascii	"uint16_t\000"
.LASF84:
	.ascii	"__RAL_data_utf8_space\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF74:
	.ascii	"__RAL_c_locale\000"
.LASF80:
	.ascii	"__RAL_c_locale_month_names\000"
.LASF24:
	.ascii	"thousands_sep\000"
.LASF136:
	.ascii	"_Bool\000"
.LASF56:
	.ascii	"__isctype\000"
.LASF138:
	.ascii	"bsp_board_led_idx_to_pin\000"
.LASF27:
	.ascii	"currency_symbol\000"
.LASF108:
	.ascii	"NRF_GPIO_PIN_INPUT_CONNECT\000"
.LASF157:
	.ascii	"nrf_gpio_pin_write\000"
.LASF151:
	.ascii	"nrf_gpio_port_out_set\000"
.LASF0:
	.ascii	"signed char\000"
.LASF85:
	.ascii	"__RAL_data_utf8_plus\000"
.LASF5:
	.ascii	"short unsigned int\000"
.LASF127:
	.ascii	"nrf_gpio_pin_sense_t\000"
.LASF37:
	.ascii	"n_cs_precedes\000"
.LASF89:
	.ascii	"__user_get_time_of_day\000"
.LASF125:
	.ascii	"NRF_GPIO_PIN_SENSE_LOW\000"
.LASF96:
	.ascii	"FILE\000"
.LASF19:
	.ascii	"__state\000"
.LASF18:
	.ascii	"NRF_GPIO_Type\000"
.LASF52:
	.ascii	"date_format\000"
.LASF104:
	.ascii	"m_sdk_errors_name_twi\000"
.LASF70:
	.ascii	"__locale_s\000"
.LASF150:
	.ascii	"nrf_gpio_port_out_clear\000"
.LASF45:
	.ascii	"int_p_sign_posn\000"
.LASF49:
	.ascii	"month_names\000"
.LASF35:
	.ascii	"p_cs_precedes\000"
.LASF94:
	.ascii	"__RAL_error_decoder_t\000"
.LASF142:
	.ascii	"bsp_board_led_invert\000"
.LASF159:
	.ascii	"nrf_gpio_pin_toggle\000"
.LASF117:
	.ascii	"NRF_GPIO_PIN_S0H1\000"
.LASF58:
	.ascii	"__tolower\000"
	.ident	"GCC: (GNU) 6.3.1 20170215 (release) [ARM/embedded-6-branch revision 245512]"
