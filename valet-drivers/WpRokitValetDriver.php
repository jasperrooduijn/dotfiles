<?php

class WpRokitValetDriver extends WordPressValetDriver
{

    /**
     * Determine if the incoming request is for a static file.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return string|false
     */
    public function isStaticFile($sitePath, $siteName, $uri)
    {

        if (strpos($uri, '/assets/') === 0) {

            // Define the path to the theme
            $sitePath = $sitePath . '/wp-content/themes/' . $siteName;
        }

        $staticFilePath = $sitePath . $uri;

        if ($this->isActualFile($staticFilePath)) {
            return $staticFilePath;
        }

        return false;
    }
}