/* setup.ld
 *
 * Linker script for the i386 setup code
 */
OUTPUT_ARCH(i386)

SECTIONS {
	.text 0x00:{*(.text)}
	.rodata :{*(.rodata)}
	.data :{*(.data)}
	.bss :{*(.bss)}
	end = .;
	.comment :{*(.comment)}
}

