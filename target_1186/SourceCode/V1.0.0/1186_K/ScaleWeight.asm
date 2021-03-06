/**
* @file     ScaleWeight.ASM
* @brief 
* @author
* @date     2019-01-07
* @version  V1.0.0
* @copyright
*/

Scale_Weight_ENTRY:
	BTFSC	ScaleFlag3,B_ScaleFlag3_UnitChang
	GOTO	Scale_W_GetCount
	BTFSS	ScaleFlag1,B_ScaleFlag1_AdcOk
	GOTO	Scale_Weight_EXIT
	
Scale_W_GetCount:
	BCF		ScaleFlag3,B_ScaleFlag3_UnitChang
	CALL	Fun_GetCount

Scale_W_StartCount:
	MOVLW	START_COUNT
	SUBWF	CountL,W
	MOVLW	00H
	SUBWFC	CountM,W
	MOVLW	00H
	SUBWFC	CountH,W
	BTFSC	STATUS,C
	GOTO	Scale_W_UpStartCount
Scale_W_DowNStartCount:
	BTFSS   ScaleFlag1,B_ScaleFlag1_AdcStable
	GOTO	Scale_W_ClrTrackCnt
	INCF	ZeroTrackCnt,F
	MOVLW	TRACK_ZERO_CNT
	SUBWF	ZeroTrackCnt,W
	BTFSS	STATUS,C
	GOTO	Scale_W_StartCount_END
	CALL	Fun_SetCountZero
	GOTO	Scale_W_ClrTrackCnt
Scale_W_UpStartCount:
	BCF		ScaleFlag1,B_ScaleFlag1_Zero
Scale_W_ClrTrackCnt:
	CLRF	ZeroTrackCnt
Scale_W_StartCount_END:

Scale_W_Mem:
Scale_W_Mem_Update:
Scale_W_Mem_END:

Scale_W_DIV10:
	CLRF	TempRam1
	CLRF	TempRam2
	CLRF	TempRam3
	MOVFW	CountH	
	MOVWF	TempRam4
	MOVFW	CountM	
	MOVWF	TempRam5
	MOVFW	CountL	
	MOVWF	TempRam6
	CLRF	TempRam11
	CLRF	TempRam12
	MOVLW	10
	MOVWF	TempRam13
	CALL	Fun_Math_Div6_3
	CALL	Fun_Math_Div6_3_Rounded
	MOVFW	TempRam5
	MOVWF	CountH
	MOVFW	TempRam6
	MOVWF	CountL
Scale_W_DIV10_END:

Scale_W_Tare:
	CALL	Fun_TareCount
Scale_W_Tare_END:

Scale_W_MinDisp:
	CALL	Fun_ChkMinDispCount
Scale_W_MinDisp_END:

Scale_W_MaxCount:
	CALL	Fun_ChkMaxDispCount
Scale_W_MaxCount_END:

Scale_W_RefreshOffTimer:
	CALL	Fun_CountRefreshOffTime
Scale_W_RefreshOffTimer_END:

Scale_W_ZeroFlag:
	CALL	Fun_CountZeroFlag
Scale_W_ZeroFlag_END:

Scale_W_UnitValue:
	CALL	Fun_CountUnitChange
Scale_W_UnitValue_END:

Scale_Weight_EXIT:
