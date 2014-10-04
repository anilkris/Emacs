/*
 * $Id: ASMCodeVisitor.java,v 1.5 2004/12/17 21:46:13 surajacharya Exp $
 * Copyright (C) 2004 Suraj Acharya (sacharya@cs.indiana.edu)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

package jde.util.usages;

import org.objectweb.asm.Label;
import org.objectweb.asm.CodeVisitor;
import jde.util.usages.ASMUsages.Signature;
import jde.util.usages.ASMUsages.Matches;
import org.objectweb.asm.Type;
import java.util.HashSet;
import java.util.Set;
import org.objectweb.asm.Constants;
import jde.util.Usages;

/**
 * ASMCodeVisitor.java
 *
 *
 * Created: Thu Nov 06 16:04:20 2003
 *
 * @author <a href="mailto:sacharya@bea.com"></a>
 * @version 1.0
 */
public class ASMCodeVisitor implements CodeVisitor {
     
    private String _matchClass;
    private ASMSignature _methodSpec;
    private String _clazz;
    private String _method;
    private String _sig;

    private Label _lastLabel;
    private int _lastLine;
    private Matches _matches;

//     public Set _labels = new HashSet();

    public ASMCodeVisitor(int access, String clazz, String method, String desc, String[] exceptions, String matchClass, ASMSignature m, Matches matches)  {
        _matchClass = matchClass;
        _methodSpec = m;
        _clazz = clazz;
        _method = method;
        _sig = desc;
        _matches = matches;
    }
    
    public String getClassName() {
        return _clazz;
    }

    public String getMethodName() {
        return _method;
    }

    public String getSig() {
        return _sig;
    }

    public String getMatchClass() {
        return _matchClass;
    }

    public void visitInsn (int opcode) {}

    public void visitIntInsn (int opcode, int operand) {}

    public void visitVarInsn (int opcode, int var) {}

    public void visitTypeInsn (int opcode, String desc) {}

    public void visitFieldInsn (int opcode, String owner, String name, String desc) {
        if ((owner.intern() == _matchClass)  && _methodSpec.matches (name, Type.getReturnType(desc), new Type[0], true)) {
            if (opcode == Constants.PUTFIELD || opcode == Constants.PUTSTATIC)
                _matches.add (this, _lastLabel, true);
            else
                _matches.add (this, _lastLabel, false);
        }
    }

    public void visitMethodInsn (int opcode, String owner, String name, String desc) {
        if ((owner.intern() == _matchClass)  && _methodSpec.matches (name, Type.getReturnType(desc), Type.getArgumentTypes(desc), false)) {
            _matches.add (this, _lastLabel, false);
        }
    }

    public void visitJumpInsn (int opcode, Label label) {}

    /**
     * Visits a label. A label designates the instruction that will be visited
     * just after it.
     *
     * @param label a {@link Label Label} object.
     */

    public void visitLabel (Label label) {
//         _labels.add (label);
        _lastLabel = label;
    }

    public void visitLdcInsn (Object cst) {}

    /**
     * Visits an IINC instruction.
     *
     * @param var index of the local variable to be incremented.
     * @param increment amount to increment the local variable by.
     */

    public void visitIincInsn (int var, int increment) {}

    public void visitTableSwitchInsn (int min, int max, Label dflt, Label labels[]) {}

    public void visitLookupSwitchInsn (Label dflt, int keys[], Label labels[]) {}

    public void visitMultiANewArrayInsn (String desc, int dims) {}

    public void visitTryCatchBlock (Label start, Label end, Label handler, String type) {}

    public void visitMaxs (int maxStack, int maxLocals) {}

    public void visitLocalVariable (
                             String name,
                             String desc,
                             Label start,
                             Label end,
                             int index) {}

    public void visitLineNumber (int line, Label start) {
        _matches.mapLabel (start, line, line == _lastLine);
        _lastLine = line;
//         if (!_labels.contains (start)) {
//             System.out.println  (start + ":"+ line + " not in _labels");
//         } else
//             _labels.remove (start);
    }

    
}
