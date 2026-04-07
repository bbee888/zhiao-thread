import { Column, Entity, ManyToOne, JoinColumn, Unique } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";
import { ArticleCategory } from "./article-category.entity";

@Entity("article_category_lang")
@Unique(["cateId", "lang"])
export class ArticleCategoryLang extends BaseEntity {
  @Column({ name: "cate_id", type: "int", comment: "分类 ID" })
  cateId: number;

  @Column({ type: "varchar", length: 10, comment: "语言" })
  lang: string;

  @Column({ name: "name", type: "varchar", length: 100, comment: "分类名称" })
  name: string;

  @ManyToOne(() => ArticleCategory)
  @JoinColumn({ name: "cate_id" })
  category: ArticleCategory;
}
