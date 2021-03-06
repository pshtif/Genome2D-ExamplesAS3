/*
 * 	Genome2D - 2D GPU Framework
 * 	http://www.genome2d.com
 *
 *	Copyright 2011-2014 Peter Stefcek. All rights reserved.
 *
 *	License:: ./doc/LICENSE.md (https://github.com/pshtif/Genome2D/blob/master/LICENSE.md)
 */
package examples.basic {

import com.genome2d.animation.GFrameAnimation;
import com.genome2d.assets.GAsset;
import com.genome2d.assets.GAssetManager;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.context.GContextConfig;
import com.genome2d.debug.GDebug;
import com.genome2d.Genome2D;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;
import flash.display.Sprite;
import flash.events.Event;

[SWF(width="800", height="600", backgroundColor="#000000", frameRate="60")]
public class BasicExample3Sprite extends Sprite
{
    /**
        Genome2D singleton instance
     **/
    private var genome:Genome2D;
	
	public function BasicExample3Sprite() {
        if (stage != null) addedToStage_handler(null);
        else addEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);
    }

    private function addedToStage_handler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);

        initGenome();
    }

    /**
        Initialize Genome2D
     **/
    private function initGenome():void {
        genome = Genome2D.getInstance();
		genome.onFailed.addOnce(genomeFailed_handler);
        genome.onInitialized.addOnce(genomeInitialized_handler);
        genome.init(new GContextConfig(stage));
    }

	/**
        Genome2D failed handler
     **/
    private function genomeFailed_handler(p_msg:String):void {
        // Here we can check why Genome2D initialization failed
    }
	
    /**
        Genome2D initialized handler
     **/
    private function genomeInitialized_handler():void {
        loadAssets();
    }
	
	/**	
	 * 	Asset loading
	 */
	private function loadAssets():void {
		GAssetManager.addFromUrl("atlas.png");
        GAssetManager.addFromUrl("atlas.xml");
		GAssetManager.addFromUrl("texture.png");
		GAssetManager.onQueueFailed.add(assetsFailed_handler);
        GAssetManager.onQueueLoaded.addOnce(assetsLoaded_handler);
        GAssetManager.loadQueue();
	}
	
	/**
	 * 	Asset loading failed
	 */
	private function assetsFailed_handler(p_asset:GAsset):void {
		// Asset loading failed at p_asset
		GDebug.trace("Can't load assets " + p_asset.url);
	}
	
	/**
	 * 	Asset loading completed
	 */
	private function assetsLoaded_handler():void {
		initExample();
	}

    /**
        Initialize Example code
     **/
    private function initExample():void {
		// Generate textures from all assets, their IDs will be the same as their asset ID
		GAssetManager.generateTextures();
		
        var sprite:GSprite;
		
		// Create a sprite
        sprite = createSprite(100, 200, "atlas_0");

		// Create a sprite with scaling
        sprite = createSprite(300, 200, "atlas_0");
        sprite.node.setScale(2,2);

		// Create a sprite with rotation
        sprite = createSprite(100, 400, "atlas_0");
        sprite.node.rotation = 0.753;

		// Create a sprite with rotation and scaling
        sprite = createSprite(300, 400, "atlas_0");
        sprite.node.rotation = 0.753;
        sprite.node.setScale(2,2);

		// Create a sprite with alpha
        sprite = createSprite(100, 300, "atlas_0");
        sprite.node.alpha = .5;

		// Create a sprite with tint
        sprite = createSprite(300, 300, "atlas_0");
        sprite.node.color = 0x00FF00;
		
		// Create an animated sprite
		sprite = createAnimatedSprite(500, 200);

		// Create an animated sprite with scaling
        sprite = createAnimatedSprite(700, 200);
        sprite.node.setScale(2,2);

		// Create an animated sprite with rotation
        sprite = createAnimatedSprite(500, 400);
        sprite.node.rotation = 0.753;

		// Create an animated sprite with rotation and scaling
        sprite = createAnimatedSprite(700, 400);
        sprite.node.rotation = 0.753;
        sprite.node.setScale(2,2);

		// Create an animated sprite with alpha
        sprite = createAnimatedSprite(500, 300);
        sprite.node.alpha = .5;

		// Create an animated sprite with tint
        sprite = createAnimatedSprite(700, 300);
        sprite.node.color = 0x00FF00;
    }

    /**
        Create a sprite helper function
     **/
    private function createSprite(p_x:int, p_y:int, p_textureId:String):GSprite {
		// Create a node with sprite component
        var sprite:GSprite = GNode.createWithComponent(GSprite) as GSprite;
        sprite.texture = GTextureManager.getTexture(p_textureId);
        sprite.node.setPosition(p_x, p_y);
        genome.root.addChild(sprite.node);

        return sprite;
    }
	
	/**
        Create an animated sprite helper function
     **/
    private function createAnimatedSprite(p_x:int, p_y:int):GSprite {
		// To animate a sprite we need a frame animation instance with defined texture frames
		var animation:GFrameAnimation = new GFrameAnimation(GTextureManager.getTextures(["atlas_1", "atlas_2", "atlas_3", "atlas_4", "atlas_5", "atlas_6", "atlas_7"]));
		animation.frameRate = 10;
		
        var sprite:GSprite = GNode.createWithComponent(GSprite) as GSprite;
        sprite.frameAnimation = animation;
        sprite.node.setPosition(p_x, p_y);
        genome.root.addChild(sprite.node);

        return sprite;
    }
}
}