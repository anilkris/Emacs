package jde.util.usages;

/**
 * This class tries to provide an abstract representation of a fully qualified
 * java class name. It uses interned strings right now but the goal is use MD5
 * hashes as an attempt to reduce the size of cache files. Since
 * <code>makeClassName</code> is not intended to be reversible in general,
 * creating a ClassPathEntry from a cached file would also require getting a
 * list of classes from the jar or directory as this list is not present in the
 * cache.
 *
 */
public class ClassName {

    public static Object makeClassName (String classname) {
        return makeInternedStringClassName(classname);
        // return makeMD5SumClassName (classname);
    }

    static private Object makeMD5SumClassName (String classname) {
        return MD5Impl.getMD5hash (classname);
    }

    static private Object makeInternedStringClassName (String classname) {
        return classname.intern();
    }

    static private class MD5Impl {
        byte [] md5;

        static java.security.MessageDigest MD5;

        static {
            try {
                MD5 = java.security.MessageDigest.getInstance ("MD5");
            } catch (java.security.NoSuchAlgorithmException e) {MD5 = null;}
        }
    
        static String getMD5hash (String str) {
            byte[] b;
            try {
                b = str.getBytes("UTF8");
            } catch (java.io.UnsupportedEncodingException e) {
                b = str.getBytes();
                // FIXME: is this wise? don't we depend on UTF8?
            }
            return getMD5hash (b, 0, b.length);
        }


        static String getMD5hash (byte[] b, int off, int len) {
            if (MD5 == null)
                if (off == 0 && len == b.length)
                    return encodeHash (b);
                else {
                    byte[] bCopy = new byte[len];
                    System.arraycopy (b, off, bCopy, 0, len);
                    return encodeHash (bCopy);
                }
            
            MD5.reset();
            MD5.update (b, off, len);
            return encodeHash (MD5.digest());
        }

        static String encodeHash (byte[] hash){
            StringBuffer sb = new StringBuffer();
            for (int i=0; i < hash.length;i++)
                sb.append ((char) hash[i]);
            return sb.toString().intern();
        }
        
    }    
    
}