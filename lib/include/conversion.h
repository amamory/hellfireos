union float_long{
	float f;
	int32_t l;
	uint32_t u;
};

float atof(const int8_t *p);
int32_t ftoa(float f, int8_t *outbuf, int32_t precision);
void *malloc(size_t size);
void free(void *ptr);