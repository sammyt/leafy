package leafy  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;

    public class PMapTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:PMap;

        [Before]
        public function setUp():void {
            instance = new PMap();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is PMap", instance is PMap);
        }
        
        [Test]
        public function addHashImpl():void {
            var thing:Thing = new Thing();
            var map:IMap = instance.plus(thing, "a value");
            
            assertThat(map.count, equalTo(1));
            assertThat(instance.count, equalTo(0));
            
            assertThat(map.at(thing), equalTo("a value"));
        }
        
        [Test]
        public function addStringKey():void {
            var map:IMap = instance.plus("f00", 55);
            assertThat(map.count, equalTo(1));
            assertThat(map.at("f00"), equalTo(55));
            
            map = map.plus("bar", "wibble");
            assertThat(map.count, equalTo(2));
            assertThat(map.at("bar"), equalTo("wibble"));
            assertThat(map.at("f00"), equalTo(55));
        }
        
        [Test]
        public function addNumberKey():void {
            var map:IMap = instance.plus(4545, "crumbs");
            assertThat(map.count, equalTo(1));
            assertThat(map.at(4545), equalTo("crumbs"));
        }
        
        [Test]
        public function removeWithIHash():void {
            var thing:Thing = new Thing();
            var map:IMap = instance.plus(thing, "a value");
            
            assertThat(map.at(thing), equalTo("a value"));
            
            var empty:IMap = map.minus(thing);
            assertThat(empty.count, equalTo(0));
        }
        
        [Test]
        public function firstMethod():void {
            var map:IMap = instance.plus("f00", 55);
            assertThat(map.count, equalTo(1));
            assertThat(map.at("f00"), equalTo(55));
            
            assertThat(map.first, equalTo(55));
        }
        
        [Test]
        [Ignore]
        public function restMethod():void {
            var map:IMap = instance.plus("f00", 55);
            map = map.plus("bar", 444);
            
            assertThat(map.count, equalTo(2));
            assertThat(IMap(map.rest).count, equalTo(1));
        }
    }
}

