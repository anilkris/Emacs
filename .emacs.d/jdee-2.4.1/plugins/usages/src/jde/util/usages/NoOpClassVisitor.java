package jde.util.usages;

import org.objectweb.asm.ClassVisitor;
import org.objectweb.asm.CodeVisitor;

/**
 * A ClassVisitor implementation that does nothing. This is used as a base class
 * to avoid repeating the empty method definitions.
 *
 **/
public class NoOpClassVisitor implements ClassVisitor {


    public void visit(int n, String string, String string1, String[] stringArray, String string2) {
    
    }

    public void visitInnerClass(String string, String string1, String string2, int n) {
    
    }

    public void visitField(int n, String string, String string1, Object object) {
    
    }

    public CodeVisitor visitMethod(int n, String string, String string1, String[] stringArray) {
        return null;
    }

    public void visitEnd() {
    
    }
}
