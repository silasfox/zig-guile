CFLAGS=`guile-config compile | sed -e "s/-pthread//g"`

all:
	zig build-exe io.zig -lc $(CFLAGS) `guile-config link`
  
clean:
	rm io
	rm -rf zig-cache
