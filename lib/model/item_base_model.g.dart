// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_base_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetItemBaseModelCollection on Isar {
  IsarCollection<ItemBaseModel> get itemBaseModels => this.collection();
}

const ItemBaseModelSchema = CollectionSchema(
  name: r'ItemBaseModel',
  id: 8670381612566142189,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _itemBaseModelEstimateSize,
  serialize: _itemBaseModelSerialize,
  deserialize: _itemBaseModelDeserialize,
  deserializeProp: _itemBaseModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'category': LinkSchema(
      id: 8212761610938302012,
      name: r'category',
      target: r'CategoryModel',
      single: true,
    ),
    r'itemModels': LinkSchema(
      id: -2579592676785689200,
      name: r'itemModels',
      target: r'ItemModel',
      single: false,
      linkName: r'item',
    )
  },
  embeddedSchemas: {},
  getId: _itemBaseModelGetId,
  getLinks: _itemBaseModelGetLinks,
  attach: _itemBaseModelAttach,
  version: '3.0.5',
);

int _itemBaseModelEstimateSize(
  ItemBaseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _itemBaseModelSerialize(
  ItemBaseModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

ItemBaseModel _itemBaseModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ItemBaseModel();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  return object;
}

P _itemBaseModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _itemBaseModelGetId(ItemBaseModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _itemBaseModelGetLinks(ItemBaseModel object) {
  return [object.category, object.itemModels];
}

void _itemBaseModelAttach(
    IsarCollection<dynamic> col, Id id, ItemBaseModel object) {
  object.id = id;
  object.category
      .attach(col, col.isar.collection<CategoryModel>(), r'category', id);
  object.itemModels
      .attach(col, col.isar.collection<ItemModel>(), r'itemModels', id);
}

extension ItemBaseModelQueryWhereSort
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QWhere> {
  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ItemBaseModelQueryWhere
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QWhereClause> {
  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterWhereClause> idBetween(
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

extension ItemBaseModelQueryFilter
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QFilterCondition> {
  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ItemBaseModelQueryObject
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QFilterCondition> {}

extension ItemBaseModelQueryLinks
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QFilterCondition> {
  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> category(
      FilterQuery<CategoryModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'category');
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'category', 0, true, 0, true);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition> itemModels(
      FilterQuery<ItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'itemModels');
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      itemModelsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'itemModels', length, true, length, true);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      itemModelsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'itemModels', 0, true, 0, true);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      itemModelsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'itemModels', 0, false, 999999, true);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      itemModelsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'itemModels', 0, true, length, include);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      itemModelsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'itemModels', length, include, 999999, true);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterFilterCondition>
      itemModelsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'itemModels', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ItemBaseModelQuerySortBy
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QSortBy> {
  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ItemBaseModelQuerySortThenBy
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QSortThenBy> {
  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ItemBaseModel, ItemBaseModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ItemBaseModelQueryWhereDistinct
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QDistinct> {
  QueryBuilder<ItemBaseModel, ItemBaseModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ItemBaseModelQueryProperty
    on QueryBuilder<ItemBaseModel, ItemBaseModel, QQueryProperty> {
  QueryBuilder<ItemBaseModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ItemBaseModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
