/* setup.ld
 *
 * Linker script for the i386 setup code
 */
OUTPUT_FORMAT("binary")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS {
	.text 0x00:{*(.text)}
	.data :{*(.data)}
	.bss :{*(.bss)}
}

