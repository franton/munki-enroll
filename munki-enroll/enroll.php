<?php

require_once( 'cfpropertylist-1.1.2/CFPropertyList.php' );

// Get the varibles passed by the enroll script
$hostname   = $_GET["hostname"];
$catalog    = $_GET["catalog"];
$manifest   = $_GET["manifest"];

// Check if manifest already exists for this machine
if ( file_exists( '../manifests/computers/' . $hostname ) )
    {
        echo "Computer manifest already exists.";
    }
else
    {
        echo "Computer manifest does not exist. Will create.";

        // Create the new manifest plist
        $plist = new CFPropertyList();
        $plist->add( $dict = new CFDictionary() );
        
        // Add manifest to release catalog by default
        $dict->add( 'catalogs', $array = new CFArray() );
        $array->add( new CFString( $catalog ) );
        
        // Add manifests
        $dict->add( 'included_manifests', $array = new CFArray() );
        $array->add( new CFString( $manifest ) );
        
        // Save the newly created plist
        $plist->saveXML( '../manifests/computers/' . $hostname );
        
    }

?>
