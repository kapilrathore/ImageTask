# ImageTask
Image Donwload Manager with caching.

Implemented UICollectionView with both vertical and horizontal options.

TableView like effect for Vertical View.
One card at a time for Horizontal View (left right swipe to scroll between images).

Implemented Image Download Manager
1. Checks if the image is in the cache.
2. If present in cache returns the image immidiately. 
3. If not, checks if there already exists a task corresponding to the image URL then increases its priority.
4. If not creates a download task for the corresponding Image URL.
