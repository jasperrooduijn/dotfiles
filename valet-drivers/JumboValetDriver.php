<?php

class JumboValetDriver extends BasicValetDriver
{
    /**
     * Determine if the driver serves the request.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return bool
     */
    public function serves($sitePath, $siteName, $uri)
    {
        return file_exists($sitePath.'/public_html/app/mu-plugins/rodesk-admin-core/rodesk-admin-core.php');
    }

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
            $sitePath = $sitePath.'/public_html/app/themes/'.$siteName;

            // Check if this is the new or old Rokit directory structure
            if(file_exists($sitePath.'/resources')) {
                $staticFilePath = $sitePath.'/resources'.$uri;
            } else {
                $staticFilePath = $sitePath.$uri;
            }

        } else {
            $staticFilePath = $sitePath.'/public_html'.$uri;
        }

        if ($this->isActualFile($staticFilePath)) {
            return $staticFilePath;
        }

        return false;
    }

    /**
     * Get the fully resolved path to the application's front controller.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return string
     */
    public function frontControllerPath($sitePath, $siteName, $uri)
    {
        $_SERVER['PHP_SELF'] = $uri;

        if (strpos($uri, '/cms/') === 0) {
            return is_dir($sitePath.'/public_html'.$uri)
                            ? $sitePath.'/public_html'.$this->forceTrailingSlash($uri).'/index.php'
                            : $sitePath.'/public_html'.$uri;
        }

        return $sitePath.'/public_html/index.php';
    }

    /**
     * Redirect to uri with trailing slash.
     *
     * @param  string $uri
     * @return string
     */
    private function forceTrailingSlash($uri)
    {
        if (substr($uri, -1 * strlen('/cms/wp-admin')) == '/cms/wp-admin') {
            header('Location: '.$uri.'/'); die;
        }

        return $uri;
    }
}