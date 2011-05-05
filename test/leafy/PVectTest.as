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
            
            assertThat(vect.at(1), equalTo(data));
        }
        
        [Test]
        public function canAddAndRemove():void {
            var vect:IVect;
            
            var data:String = "wooo";
            
            vect = instance.plus(data);
            
            assertThat(instance.count, equalTo(0));
            assertThat(vect.count, equalTo(1));
            
            assertThat(vect.at(1), equalTo(data));
            
            var removed:IVect = vect.minus(1);
            assertThat(removed.count, equalTo(0));
            assertThat(vect.count, equalTo(1));
        }
    }
}

