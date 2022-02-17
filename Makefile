CFLAGS=`guile-config compile | sed -e "s/-pthread//g"`

all: fib io
  
clean:
	rm -rf zig-cache
	rm io fib

fib:
	zig build-exe fib.zig -lc $(CFLAGS) `guile-config link`

io:
	zig build-exe io.zig -lc $(CFLAGS) `guile-config link`
