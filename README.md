# Apache Spark with Scala

This repository contains my notes from the Apache Spark with Scala - Hands On with Big Data! course.

## Quick Reference

[Official API documentation](https://spark.apache.org/docs/2.4.0/api/scala/)

### RDD

A Resilient Distributed Dataset (RDD), the basic abstraction in Spark. Represents an immutable, partitioned collection of elements that can be operated on in parallel.

|Signature|Description|
|-------|-------|
| map[U](f: (T) ⇒ U)(implicit arg0: ClassTag[U]): RDD[U] |Return a new RDD by applying a function to all elements of this RDD.|
| filter(f: (T) ⇒ Boolean): RDD[T] |Return a new RDD containing only the elements that satisfy a predicate.|
| flatMap[U](f: (T) ⇒ TraversableOnce[U]): RDD[U] |Return a new RDD by first applying a function to all elements of this RDD, and then flattening the results.|
| cartesian[U](other: RDD[U]): RDD[(T, U)]|Return the Cartesian product of this RDD and another one, that is, the RDD of all pairs of elements (a, b) where a is in this and b is in other.|
| intersection(other: RDD[T]): RDD[T] |Return the intersection of this RDD and another one. The output will not contain any duplicate elements, even if the input RDDs did. |
| subtract(other: RDD[T]): RDD[T] |Return an RDD with the elements from this that are not in other.|
| union(other: RDD[T]): RDD[T] |Return the union of this RDD and another one. Any identical elements will appear multiple times (use .distinct() to eliminate them). |
| zip[U](other: RDD[U]): RDD[(T, U)] |Zips this RDD with another one, returning key-value pairs with the first element in each RDD, second element in each RDD, etc.|
| distinct(): RDD[T] |Return a new RDD containing the distinct elements in this RDD.|
| sample(withReplacement: Boolean, fraction: Double, seed: Long = Utils.random.nextLong): RDD[T] |Return a sampled subset of this RDD. |
| collect(): Array[T] |Return an array that contains all of the elements in this RDD. |
| take(num: Int): Array[T] |Take the first num elements of the RDD. It works by first scanning one partition, and use the results from that partition to estimate the number of additional partitions needed to satisfy the limit. |
| top(num: Int): Array[T] |Returns the top k (largest) elements from this RDD as defined by the specified implicit Ordering[T] and maintains the ordering.|
| count(): Long |Return the number of elements in the RDD.|
| countByValue(): Map[T, Long] |Return the count of each unique value in this RDD as a local map of (value, count) pairs.|
| max(): T |Returns the max of this RDD as defined by the implicit Ordering[T].|
| min(): T |Returns the min of this RDD as defined by the implicit Ordering[T].|
| reduce(f: (T, T) ⇒ T): T |Reduces the elements of this RDD using the specified commutative and associative binary operator.|
| saveAsTextFile(path: String): Unit |Save this RDD as a text file, using string representations of elements.|

### PairRDDFunctions
Extra functions available on RDDs of (key, value) pairs through an implicit conversion. 

|Signature|Description|
|-------|-------|
| reduceByKey(func: (V, V) ⇒ V): RDD[(K, V)] |Merge the values for each key using an associative and commutative reduce function.|
| groupByKey(): RDD[(K, Iterable[V])] |Group the values for each key in the RDD into a single sequence.|
| mapValues[U](f: (V) ⇒ U): RDD[(K, U)] |Pass each value in the key-value pair RDD through a map function without changing the keys; this also retains the original RDD's partitioning.|
| subtractByKey[W](other: RDD[(K, W)]): RDD[(K, V)] |Return an RDD with the pairs from this whose keys are not in other.|
| countByKey(): Map[K, Long] |Count the number of elements for each key, collecting the results to a local Map. |
| keys: RDD[K] |Return an RDD with the keys of each tuple.|
| values: RDD[V] |Return an RDD with the values of each tuple.|
| join[W](other: RDD[(K, W)]): RDD[(K, (V, W))] |Return an RDD containing all pairs of elements with matching keys in this and other.|
| leftOuterJoin[W](other: RDD[(K, W)]): RDD[(K, (V, Option[W]))] |Perform a left outer join of this and other.|
| rightOuterJoin[W](other: RDD[(K, W)]): RDD[(K, (Option[V], W))] |Perform a right outer join of this and other.|
| fullOuterJoin[W](other: RDD[(K, W)], partitioner: Partitioner): RDD[(K, (Option[V], Option[W]))] |Perform a full outer join of this and other. |