import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Product } from "./entities/product.entity";
import { ProductLang } from "./entities/product-lang.entity";
import { ProductCategory } from "./entities/product-category.entity";
import { ProductCategoryLang } from "./entities/product-category-lang.entity";
import { ProductService } from "./product.service";
import { ProductController } from "./product.controller";

@Module({
  imports: [
    TypeOrmModule.forFeature([Product, ProductLang, ProductCategory, ProductCategoryLang]),
  ],
  controllers: [ProductController],
  providers: [ProductService],
  exports: [ProductService],
})
export class ProductModule {}
