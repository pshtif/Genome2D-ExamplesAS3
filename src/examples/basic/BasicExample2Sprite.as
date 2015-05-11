/*
 * 	Genome2D - 2D GPU Framework
 * 	http://www.genome2d.com
 *
 *	Copyright 2011-2014 Peter Stefcek. All rights reserved.
 *
 *	License:: ./doc/LICENSE.md (https://github.com/pshtif/Genome2D/blob/master/LICENSE.md)
 */
package examples.basic {
	import com.genome2d.assets.GAssetManager;
	import com.genome2d.components.renderable.GSprite;
	import com.genome2d.context.GContextConfig;
	import com.genome2d.Genome2D;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTextureManager;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;


[SWF(width="800", height="600", backgroundColor="#000000", frameRate="60")]
public class BasicExample2Sprite extends Sprite
{
    /**
        Genome2D singleton instance
     **/
    private var genome:Genome2D;

    public function BasicExample2Sprite() {
        if (stage != null) addedToStageHandler(null);
        else addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        initGenome();
    }
	
    /**
        Initialize Genome2D
     **/
    private function initGenome():void {
        // Get the Genome2D instance
        genome = Genome2D.getInstance();
        // Add a callback for Genome2D initialization
        genome.onInitialized.addOnce(genomeInitializedHandler);
        // Initialize Genome2D
        genome.init(new GContextConfig(stage));
    }

    /**
        Genome2D initialized handler
     **/
    private function genomeInitializedHandler():void {
        initAssets();
    }

    /**
        Initialize assets
     **/
    private function initAssets():void {
        GAssetManager.addFromUrl("atlas.png");
        GAssetManager.addFromUrl("atlas.xml");
        GAssetManager.onQueueLoaded.add(assetsLoaded_handler);
        GAssetManager.loadQueue();
    }

    /**
        Assets initialization handler dispatched after all assets were initialized
     **/
    private function assetsLoaded_handler():void {
        initExample();
    }

    /**
        Initialize Example code
     **/
    private function initExample():void {
		GAssetManager.generateTextures();

        // Create top left sprite without any transformation
        var sprite:GSprite;

        sprite = createSprite(300, 200, "atlas_0");

        // Create top right sprite with scale
        sprite = createSprite(500, 200, "atlas_0");
        sprite.node.setScale(2,2);

        // Create bottom left sprite with rotation
        sprite = createSprite(300, 400, "atlas_0");
        sprite.node.rotation = 0.753;

        // Create bottom right sprite with scale and rotation
        sprite = createSprite(500, 400, "atlas_0");
        sprite.node.rotation = 0.753;
        sprite.node.setScale(2,2);

        // Create middle left sprite with alpha
        sprite = createSprite(300, 300, "atlas_0");
        sprite.node.alpha = .5;

        // Create middle right sprite with color tint
        sprite = createSprite(500, 300, "atlas_0");
        sprite.node.color = 0x00FF00;
    }

    /**
        Create a sprite helper function
     **/
    private function createSprite(p_x:int, p_y:int, p_textureId:String):GSprite {
        // Create a node with sprite components
        var sprite:GSprite = GNode.createWithComponent(GSprite) as GSprite;
        // Assign a textures to the sprite based on the textures ID
        sprite.texture = GTextureManager.getTexture(p_textureId);
        // Set transform position for this node
        sprite.node.setPosition(p_x, p_y);
        // Add the node to root of the render graph
        genome.root.addChild(sprite.node);

        return sprite;
    }
}
}
