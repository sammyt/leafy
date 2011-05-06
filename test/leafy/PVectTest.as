package leafy  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;
    
    public class PVectTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:PVect;

        [Before]
        public function setUp():void {
            instance = new PVect();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is PVect", instance is PVect);
        }
        
        [Test]
        public function canAdd():void {
            var vect:IVect;
            
            var data:String = "wooo";
            
            vect = instance.plus(data);
            
            assertThat(instance.count, equalTo(0));
            assertThat(vect.count, equalTo(1));
            
            assertThat(vect.at(0), equalTo(data));
        }
        
        [Test]
        public function canAddAndRemove():void {
            var vect:IVect;
            
            var data:String = "wooo";
            
            vect = instance.plus(data);
            
            assertThat(instance.count, equalTo(0));
            assertThat(vect.count, equalTo(1));
            
            assertThat(vect.at(0), equalTo(data));
            
            var removed:IVect = vect.minus(0);
            assertThat(removed.count, equalTo(0));
            assertThat(vect.count, equalTo(1));
        }
        
        [Test]
        public function canUseSeqFirst():void {
            var v:IVect = instance.plus("one");
            v = v.plus("two");
            v = v.plus("three");
            
            assertThat(v.first, equalTo("one"));
        }
        
        [Test]
        public function canUseSeqRest():void {
            var v:IVect = instance.plus("one");
            v = v.plus("two");
            v = v.plus("three");
            
            assertThat(IVect(v.rest).count, equalTo(2));
            assertThat(v.rest.first, equalTo("two"));
            assertThat(v.rest.rest.first, equalTo("three"));
        }
        
        [Test]
        public function uniteAddsItem():void {
            var vect:ISeq = instance.unite("bananna");
            assertThat(vect.first, equalTo("bananna"));
        }
        
        [Test]
        public function uniteAddsItems():void {
            var vect:ISeq = instance.unite("bananna", "sausage", "cheese");
            assertThat(IVect(vect).count, equalTo(3));
            assertThat(vect.first, equalTo("bananna"));
            assertThat(vect.rest.first, equalTo("sausage"));
            assertThat(vect.rest.rest.first, equalTo("cheese"));
        }
    }
}

