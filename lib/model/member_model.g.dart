// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetMemberModelCollection on Isar {
  IsarCollection<MemberModel> get memberModels => this.collection();
}

const MemberModelSchema = CollectionSchema(
  name: r'MemberModel',
  id: 8595147604790784312,
  properties: {},
  estimateSize: _memberModelEstimateSize,
  serialize: _memberModelSerialize,
  deserialize: _memberModelDeserialize,
  deserializeProp: _memberModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'user': LinkSchema(
      id: -7492003450547262620,
      name: r'user',
      target: r'UserModel',
      single: true,
    ),
    r'items': LinkSchema(
      id: 8265385596495079824,
      name: r'items',
      target: r'ItemModel',
      single: false,
    ),
    r'trips': LinkSchema(
      id: -2356310405296005781,
      name: r'trips',
      target: r'TripModel',
      single: false,
      linkName: r'members',
    )
  },
  embeddedSchemas: {},
  getId: _memberModelGetId,
  getLinks: _memberModelGetLinks,
  attach: _memberModelAttach,
  version: '3.0.5',
);

int _memberModelEstimateSize(
  MemberModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _memberModelSerialize(
  MemberModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {}
MemberModel _memberModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MemberModel();
  object.id = id;
  return object;
}

P _memberModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _memberModelGetId(MemberModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _memberModelGetLinks(MemberModel object) {
  return [object.user, object.items, object.trips];
}

void _memberModelAttach(
    IsarCollection<dynamic> col, Id id, MemberModel object) {
  object.id = id;
  object.user.attach(col, col.isar.collection<UserModel>(), r'user', id);
  object.items.attach(col, col.isar.collection<ItemModel>(), r'items', id);
  object.trips.attach(col, col.isar.collection<TripModel>(), r'trips', id);
}

extension MemberModelQueryWhereSort
    on QueryBuilder<MemberModel, MemberModel, QWhere> {
  QueryBuilder<MemberModel, MemberModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MemberModelQueryWhere
    on QueryBuilder<MemberModel, MemberModel, QWhereClause> {
  QueryBuilder<MemberModel, MemberModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MemberModelQueryFilter
    on QueryBuilder<MemberModel, MemberModel, QFilterCondition> {
  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MemberModelQueryObject
    on QueryBuilder<MemberModel, MemberModel, QFilterCondition> {}

extension MemberModelQueryLinks
    on QueryBuilder<MemberModel, MemberModel, QFilterCondition> {
  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> user(
      FilterQuery<UserModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'user');
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> userIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'user', 0, true, 0, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> items(
      FilterQuery<ItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'items');
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', length, true, length, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, true, 0, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, false, 999999, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, true, length, include);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', length, include, 999999, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'items', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> trips(
      FilterQuery<TripModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'trips');
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      tripsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'trips', length, true, length, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition> tripsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'trips', 0, true, 0, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      tripsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'trips', 0, false, 999999, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      tripsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'trips', 0, true, length, include);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      tripsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'trips', length, include, 999999, true);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterFilterCondition>
      tripsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'trips', lower, includeLower, upper, includeUpper);
    });
  }
}

extension MemberModelQuerySortBy
    on QueryBuilder<MemberModel, MemberModel, QSortBy> {}

extension MemberModelQuerySortThenBy
    on QueryBuilder<MemberModel, MemberModel, QSortThenBy> {
  QueryBuilder<MemberModel, MemberModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MemberModel, MemberModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension MemberModelQueryWhereDistinct
    on QueryBuilder<MemberModel, MemberModel, QDistinct> {}

extension MemberModelQueryProperty
    on QueryBuilder<MemberModel, MemberModel, QQueryProperty> {
  QueryBuilder<MemberModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }
}
