import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Company } from "./entities/company.entity";
import { CompanyLang } from "./entities/company-lang.entity";
import { CompanyService } from "./company.service";
import { CompanyController } from "./company.controller";

@Module({
  imports: [TypeOrmModule.forFeature([Company, CompanyLang])],
  providers: [CompanyService],
  controllers: [CompanyController],
  exports: [CompanyService],
})
export class CompanyModule {}
