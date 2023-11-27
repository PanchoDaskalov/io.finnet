module "dev"{
	source = "./env/dev"
}

module "stage"{
	source = "./env/stage"
}

module "prod"{
	source = "./env/prod"
}