package leafy 
{

public final class IntTree {

    public static const EMPTY:IntTree = new IntTree();

    public var key:Number;
    public var value:Object;
    public var left:IntTree;
    public var right:IntTree;
    public var count:uint = 0;
    
    public function IntTree(key:Number = 0, value:Object= null, 
            left:IntTree = null, right:IntTree = null) {
        this.key = key;
        this.left = left;
        this.right = right;
        this.value = value;
        
        if(left && right) {
            count = 1 + left.count + right.count;
        }
    }
    
    public function find(key:Number):Object {
        if(count == 0) {
            return null;
        }
        else if(key > this.key) {
            return right.find(key-this.key);
        }
        else if(key < this.key) {
            return left.find(key-this.key);
        }
        return value
    }
    
    public function plus(key:Number, value:Object):IntTree {
        if(count == 0) {
            return new IntTree(key, value, this, this);
        }
        ;
        if(key < this.key) {
			return balanced(left.plus(key - this.key, value), right);
		} 
		else if(key > this.key) {
			return balanced(left, right.plus(key - this.key, value));
		}
		if(value == this.value) {
		    return this;
		}
        return new IntTree(key, value, left, right);
    }
    
    public function minus(key:Number):IntTree {
        if(!count) {
            return this;
        }
        if(key < this.key) {
            return balanced(left.minus(key - this.key), right);
        }
        if(key > this.key) {
            return balanced(left, right.minus(key - this.key));
        }
        
        if(left.count == 0) {
            return right.withKey(right.key + this.key);
        }
        if(right.count == 0) {
            return left.withKey(left.key + this.key);
        }
        
        var newKey:Number = right.minKey + this.key;
        var newVal:* = right.find(newKey - this.key);
        
        var newRight:IntTree = right.minus(newKey - this.key);
        newRight = newRight.withKey((newRight.key + this.key) - newKey);
        
        var newLeft:IntTree = left.withKey((left.key + this.key) - newKey);
        
        return rebalanced(newKey, newVal, newLeft, newRight);
    }
    
    public function shiftBelowKey(key:int, delta:int):IntTree {
        if(delta == 0) {
            return this;
        }
        
        if(count == 0) {
            return this;
        }
        
        if(this.key < key) {
            return new IntTree(this.key + delta, value, left, 
                right.shiftAboveKey(key - this.key, - delta));
        }
        
        var nextLeft:IntTree = left.shiftBelowKey(key - this.key, delta);
        
        if(nextLeft == left) {
            return this;
        }
        return new IntTree(this.key, value, nextLeft, right);
    }
    
    public function shiftAboveKey(key:int, delta:int):IntTree {
        if(delta == 0) {
            return this;
        }
        
        if(count == 0) {
            return this;
        }
        
        if(this.key >= key) {
            return new IntTree(this.key + delta, value, 
                left.shiftBelowKey(key - this.key, - delta), right);
        }
        var nextRight:IntTree = right.shiftAboveKey(key - this.key, delta);
        
		if(nextRight == right) {
		    return this;
		} 
		return new IntTree(this.key, value, left, nextRight);
    }
    
    private function get minKey():Number {
        if(left.count == 0) {
            return key;
        }
        return left.minKey + key;
    }
    
    public function get first():IntTree {
        
        var n:IntTree = this;
        
        while(n.left && n.count > 1) {
            n = n.left;
        }
        
        return n;
    }
    
    public function balanced(left:IntTree, right:IntTree):IntTree {
        if(left == this.left && right == this.right) {
            return this;
        }
        return rebalanced(key, value, left, right);
    }
    
    public function withKey(key:Number):IntTree {
        if(key == this.key
            || count == 0) {
            return this;
        }
        return new IntTree(key, value, left, right);
    }
    
    public function toString():String {
        return ["Key ", key, " value ", value, " count ", count].join("");
    }
    
    public static const OMEGA:int = 5;
    public static const ALPHA:int = 2;
    
    public static function rebalanced(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
        if(left.count + right.count > 1) {
            if(left.count >= OMEGA * right.count) {
                if(left.right.count < ALPHA * left.left.count) {
                    return rotateRight(key, value, left, right);
                }
                return rotateRightTwice(key, value, left, right);
            }
            else if(right.count >= OMEGA * left.count) {
                if(right.left.count < ALPHA * right.right.count) {
                    return rotateLeft(key, value, left, right);
                }
                return rotateLeftTwice(key, value, left, right);
            }
        }
        return new IntTree(key, value, left, right);
    }
    
    public static function rotateRight(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
         var ll:IntTree = left.left
         var lr:IntTree = left.right;
         
		 return new IntTree(left.key+key, left.value,
		 		ll,
		 		new IntTree(-left.key, value,
		 				lr.withKey(lr.key+left.key),
		 				right));
    }
    
    public static function rotateRightTwice(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
        var lr:IntTree = left.right;
        var ll:IntTree = left.left;
        
        var lrl:IntTree = lr.left;
		var lrr:IntTree = lr.right;

        return new IntTree(lr.key+left.key+key, lr.value,
				new IntTree(-lr.key, left.value,
						ll,
						lrl.withKey(lrl.key+lr.key)),
				new IntTree(-left.key-lr.key, value,
						lrr.withKey(lrr.key+lr.key+left.key),
						right));
    }
    
    public static function rotateLeft(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
        var rl:IntTree = right.left
        var rr:IntTree = right.right;
        
		return new IntTree(right.key+key, right.value,
				new IntTree(-right.key, value,
						left,
						rl.withKey(rl.key+right.key)),
			    rr);
    }
    
    public static function rotateLeftTwice(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
        var rl:IntTree = right.left;
        var rr:IntTree = right.right;
        
        var rll:IntTree = rl.left;
        var rlr:IntTree = rl.right;
        
        return new IntTree(rl.key+right.key+key, rl.value,
				new IntTree(-right.key-rl.key, value,
						left,
						rll.withKey(rll.key+rl.key+right.key)),
				new IntTree(-rl.key, right.value,
						rlr.withKey(rlr.key+rl.key),
						rr));
    }
    
}
}

