; CONFIGURACIÓN
 __CONFIG _INTRC_OSC_NOCLKOUT & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

    LIST P=16F628A
    #include <p16f628a.inc>
    
; Variables
    cblock 0x20
	conta	    ; Contador de LEDs
    endc
    
; Inicio de programa
    org		0x00	    ; iniciamos el programa en la dirección cero
    bsf		STATUS, 5   ; Vamos al banco 1
    clrf	TRISB	    ; Configuramos PORTB como salida
    movlw	b'00000111' ; Configuramos OPTION_REG para prescaler 1:256
    movwf	OPTION_REG  ; Guardamos la configuracion en TMR0
    bcf		STATUS, 5   ; Regresamos al banco 0
 
; Creamos la rutina de inicio de los LEDs
inicio:
    movlw	.8	    ; Numero de LEDs o rotaciones que vamos a utilizar
    movwf	conta	    ; Asignamos los LEDs a la variable conta
    movlw	b'00000001' ; Configuramos todo el PORTB
    movwf	PORTB	    ; Guardamos en PORTB
    
bucle_principal:
    movlw	.250	    ; Asignamos los milisegundos
    call	delay_ms    ; Llamamos a nuestra rutina de retardo
    decfsz	conta, 1    ; Decrementamos en 1 el contador, esto son los LEDs, y cuando de cero se salta la instruccion de goto $+2
    goto	$+2	    ; Saltamos a la siguientes dos instrucciones
    goto	inicio	    ; Cuando decfsz es 0 saltamos a esta instruccion
    bsf		STATUS, 0   ; Con este bit, decimos si el LED se va a quedar encendido(bsf) o apagado(bcf)
    rlf		PORTB, 1    ; Rotamos los bits a la izquierda
    goto	bucle_principal

#include <delay.inc>
    
    end
    