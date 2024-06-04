#!/bin/sh
cat > feeds/packages/libs/libpfring/patches/999-fix-iss23621.patch << 'EOF'
#https://github.com/openwrt/packages/issues/23621
--- a/kernel/pf_ring.c
+++ b/kernel/pf_ring.c
@@ -5562,18 +5562,18 @@ static int ring_bind(struct socket *sock, struct sockaddr *sa, int addr_len)
 {
   struct sock *sk = sock->sk;
-  char name[sizeof(sa->sa_data)+1];
+  char name[sizeof(sa->sa_data_min)+1];
 
   debug_printk(2, "ring_bind() called\n");
 
   /*
    * Check legality
    */
   if(addr_len != sizeof(struct sockaddr))
     return(-EINVAL);
   if(sa->sa_family != PF_RING)
     return(-EINVAL);
 
-  memcpy(name, sa->sa_data, sizeof(sa->sa_data));
+  memcpy(name, sa->sa_data, sizeof(sa->sa_data_min));
 
   /* Add trailing zero if missing */
   name[sizeof(name)-1] = '\0';
EOF