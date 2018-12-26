﻿/**
* @file  ScaleInit.ASM
* @brief 
* @author
* @date     2018-12-22
* @version  V1.0.0
* @copyright
*/

ScaleInit_Entry:
	BCF		INTE,GIE
	
ScaleInit_IO:
	CALL    Fun_GPIO_Init
	
ScaleInit_Power:
	CALL	Fun_power_Init
	CALL    Fun_Delay_1MS

ScaleInit_Ram_Zero:
    BCF     BSR,IRP0
	MOVLW	ScaleFlag1
	CALL	Fun_RAM_Zero
	
;	BCF     BSR,IRP0
;	MOVLW	ScaleFlag1
;	CALL	Fun_RAM_Zero
	
ScaleInit_TIMER:

ScaleInit_LCD:
	CALL	Fun_LCD_Init
	CALL    Fun_LCD_ResetAllBuf
	CALL    Fun_LCD_Load

ScaleInit_ADC:
	CALL	Fun_ADC_Init
	
ScaleInit_UART:

ScaleInit_LO:

ScaleInit_LoadParam:
	MOVLW   HIGH	3000
	MOVWF	CalDot1H
	MOVLW   LOW		3000
	MOVWF	CalDot1L
	
	MOVLW   HIGH	6000
	MOVWF	CalDot2H
	MOVLW   LOW		6000
	MOVWF	CalDot2L
	
	MOVLW   HIGH	9000
	MOVWF	CalDot3H
	MOVLW   LOW		9000
	MOVWF	CalDot3L
	
ScaleInit_INT:
	BSF		INTE,GIE

