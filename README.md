## Rutina de Retardo en Milisegundos

Este código implementa un retardo configurable en milisegundos utilizando las rutinas `delay_ms` y `delay_1ms`. La rutina utiliza el temporizador TMR0 para generar retardos precisos.

---

## Descripción General

La rutina consta de dos partes:

1. **`delay_ms`**: Genera un retardo largo en milisegundos. El número de milisegundos se pasa a través del registro `WREG`.
2. **`delay_1ms`**: Genera un retardo exacto de 1 milisegundo utilizando el temporizador TMR0.

---

## Código

```asm
; Retardo en milisegundos
delay_ms:
    movwf   temp1       ; Guardamos el valor actual en temp1
delay_ms_loop:
    call    delay_1ms   ; Llamamos a la rutina de 1 ms
    decfsz  temp1, 1    ; Decrementamos temp1; si es 0, salimos del bucle
    goto    delay_ms_loop
    return

; Retardo de 1 ms usando TMR0
delay_1ms:
    clrf    TMR0        ; Inicializamos TMR0
delay_1ms_wait:
    btfss   TMR0, 2     ; Esperamos hasta que el bit 2 de TMR0 se active
    goto    delay_1ms_wait
    return
```    
---

## Explicación

1. **delay_ms - Retardo en Milisegundos**

Esta rutina genera un retardo de varios milisegundos según el valor almacenado en WREG al momento de la llamada.

	1. Guardar el valor en temp1:

	```asm
	movwf temp1
	```
	2. El valor de WREG (el número de milisegundos a retardar) se guarda en temp1.
	Bucle de Retardo:

	``asm
	delay_ms_loop:
	    call delay_1ms
	    decfsz temp1, 1
	    goto delay_ms_loop
	```

	* Cada iteración llama a delay_1ms para un retardo de 1 ms.
	* El registro temp1 se decrementa. Cuando llega a 0, el bucle termina.

	3. Finalizar la rutina:

	```asm
	return
	```

2. **delay_1ms - Retardo de 1 Milisegundo**

Esta subrutina genera un retardo exacto de 1 ms utilizando el temporizador TMR0.

	1. Inicializar TMR0:

	```asm
	clrf TMR0
	```

	* Borra el contenido de TMR0 para iniciar el conteo desde 0.

	Esperar que TMR0 alcance un valor específico:

	```asm
	delay_1ms_wait:
	    btfss TMR0, 2
	    goto delay_1ms_wait
	```

	* Verifica continuamente el bit 2 de TMR0. Este bit se activa automáticamente cuando el temporizador alcanza un valor predefinido.

	3. Finalizar la rutina:

	```asm
	return
	```
	
---
	
## Notas

Configuración de TMR0:

Asegúrate de configurar el prescaler y la fuente del reloj correctamente en OPTION_REG para que el temporizador TMR0 funcione de acuerdo con la frecuencia del reloj del microcontrolador.
Precisión:

La duración del retardo depende de la frecuencia del reloj del microcontrolador. Calcula adecuadamente los valores del prescaler y la relación con la frecuencia del reloj.
Registros Temporales:

Asegúrate de que temp1 no se use para otras operaciones mientras la rutina esté en ejecución.

----

