#ifndef __ELHASO_TYPES_H__
#define __ELHASO_TYPES_H__

/// Type of directory where we want to open a file.
enum DIR_TYPE_ENUM
{
	DIR_BUNDLE,		///< Open the program's bundle for data reading.
	DIR_DOCS,		///< Directory for persistent data, visible to the user.
	DIR_CACHE,		///< Directory where persistant non backed data is stored.
	DIR_LIB, 		///< Backed up data, but not visible/exposed to the user.
};

typedef enum DIR_TYPE_ENUM DIR_TYPE;

#endif // __ELHASO_TYPES_H__

// vim:tabstop=4 shiftwidth=4 syntax=objc
