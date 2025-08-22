# REST API Versioning and backward compatibility

Field: Content

## Tl;dr

The "how to version API" question became very philosophical. There is no single correct answer how to do it. 

It was decided to version Kontur APIs using URI approach, by putting the API version number in the URI.

Example: 
* <https://api.kontur.io/layers/conformance> (outdated version) → <https://api.kontur.io/layers/v2/conformance> (the latest version)
* <https://apps.kontur.io/events/v1/> (the latest version)

Backward compatibility for the API is a must. 

🟢 New query or body request parameters can be added

🟢 New response parameters is ok

🛑 Do not remove/rename existing query and body parameters 

🛑 Do not remove/rename existing API paths.

## Why to bother?
* Software evolves, APIs must be versioned.**

Wherever possible, REST resources and their representations have to be maintained in a *backwards compatible* manner. If it is necessary to change an API in a way that is not backwards compatible, a *new* resource will be created using the new representation.

There is nothing wrong with introducing a new version of an API when it is the most sensible thing to do. By all means, do your damndest to get it “right” from day one but do so with the expectation that “right” is a temporary state. This is why we need to be able to version.

## How to support backward compatibility

An API is Backwards Compatible if a program written against one version of that API will continue to work the same way, without modification, against future versions of the API.

#### **Stable URIs**

If a resource exists at a particular URI, that same resource will continue to exist with the same meaning in future versions. This means:
* The meaning of HTTP response codes can be trusted. If a URI that used to 200 now returns a 404, you know it is because the resource cannot be found, not because the resource has moved to another location.
* A resource MAY support additional query parameters in future versions but they WILL NOT be mandatory. The absence of a value or a default value (as appropriate) will maintain prior behavior.
* If a resource accepts a representation (e.g. via POST or PUT), it will continue to accept the same representation in future versions. Any additional properties that are recognized in a resource WILL NOT be mandatory, and the default value assumed in their absence will be chosen to maintain the previous meaning of the resource.
* A resource MAY be modified to return a "redirection" response code (e.g. 301, 302) instead of directly returning the resource. Clients MUST handle HTTP-level redirects, and respect HTTP headers (e.g. Location).

#### **Structured representations (application/json)**

Resources with a media type of `application/json` have additional stability guarantees.

If a property exists in a JSON object returned by the REST API, it will continue to be returned with the same name, and the same value type (i.e. String, number, array or object). If that value is an array, the type of the contents of the array will not change. If the value is an object, that object will satisfy the same compatibility guarantees as the document as a whole:
* If a property has a primitive type and the API documentation does not explicitly limit its possible values, clients MUST NOT assume the values are constrained to a particular set of possible responses.
* If a property of an object is not explicitly declared as mandatory in the API, clients MUST NOT assume it will be present.
* New properties MAY be added to a representation at any time, but a new property MUST NOT alter the meaning of an existing property.
* If a property of an object is a URI, then the resource identified by that URI MUST maintain the same compatibility guarantee.

## How to version

There are a lot of holly wars happen on this topic in the internet. But, according to [this post](http://www.lexicalscope.com/blog/2012/03/12/how-are-rest-apis-versioned/ "http://www.lexicalscope.com/blog/2012/03/12/how-are-rest-apis-versioned/") most of the big public APIs put the API version number in the URI. The same approached is used in Kontur. 

By this time API version was incremented only for one service: Layers API (kcapi previously)

<https://api.kontur.io/layers> become <https://api.kontur.io/layers/v2/>

## References

<https://www.troyhunt.com/your-api-versioning-is-wrong-which-is/>

<https://stackoverflow.com/questions/389169/best-practices-for-api-versioning>

<http://www.lexicalscope.com/blog/2012/03/12/how-are-rest-apis-versioned/>

<https://developer.atlassian.com/platform/marketplace/atlassian-rest-api-policy/> 

