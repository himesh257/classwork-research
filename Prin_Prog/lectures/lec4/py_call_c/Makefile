%.o: %.c
	gcc -c -fPIC $^

libfoo.so: foo.o
	gcc -shared -o $@ $^

.PHONY: all clean

all: libfoo.so

clean:
	rm -f *.o *.so *.pyc
