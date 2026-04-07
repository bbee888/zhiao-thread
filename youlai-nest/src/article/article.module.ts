import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Article } from "./entities/article.entity";
import { ArticleLang } from "./entities/article-lang.entity";
import { ArticleCategory } from "./entities/article-category.entity";
import { ArticleCategoryLang } from "./entities/article-category-lang.entity";
import { ArticleService } from "./article.service";
import { ArticleController } from "./article.controller";

@Module({
  imports: [
    TypeOrmModule.forFeature([Article, ArticleLang, ArticleCategory, ArticleCategoryLang]),
  ],
  controllers: [ArticleController],
  providers: [ArticleService],
  exports: [ArticleService],
})
export class ArticleModule {}
