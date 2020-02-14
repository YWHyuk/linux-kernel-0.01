/* setup.ld
 *
 * Linker script for the i386 setup code
 */
OUTPUT_FORMAT("binary")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS {
	.text 0x00:{*(.text)}
	.signature 0x01FE:{
		BYTE(0x55)
		BYTE(0xAA)
	}
}
