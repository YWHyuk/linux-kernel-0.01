#include <stdio.h>
#include <stdlib.h>
int main(){
	FILE* img= fopen("Image","rb");
	FILE* floppy_img = fopen("fdisk.img","wb");
	unsigned long img_len, remain_len;
	char *buffer;
	char *buffer2;
	fseek(img, 0, SEEK_END);
	img_len = ftell(img);
	remain_len = 80*18*2*512 - img_len;
	printf("img_len: %ld\nremain_len: %ld",img_len,remain_len);
	fseek(img, 0, SEEK_SET);
	buffer = (char*)(malloc(img_len));
	buffer2 = (char*)(calloc(remain_len,1));
	fread(buffer, img_len, 1, img);
	fwrite(buffer, img_len, 1, floppy_img);
	fwrite(buffer2, remain_len, 1, floppy_img);

}
