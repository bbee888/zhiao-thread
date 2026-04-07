import { Column, Entity, ManyToOne, JoinColumn, Unique } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";
import { Article } from "./article.entity";

@Entity("article_lang")
@Unique(["articleId", "lang"])
export class ArticleLang extends BaseEntity {
  @Column({ name: "article_id", type: "int", comment: "文章 ID" })
  articleId: number;

  @Column({ type: "varchar", length: 10, comment: "语言 en/ar/th/ms/id/vi/fr/it/km" })
  lang: string;

  @Column({ name: "title", type: "varchar", length: 255, comment: "文章标题" })
  title: string;

  @Column({ name: "content", type: "longtext", nullable: true, comment: "内容" })
  content: string;

  @Column({ name: "keywords", type: "varchar", length: 255, default: "", comment: "SEO 关键词" })
  keywords: string;

  @Column({ name: "description", type: "varchar", length: 500, default: "", comment: "SEO 描述" })
  description: string;

  @ManyToOne(() => Article)
  @JoinColumn({ name: "article_id" })
  article: Article;
}
