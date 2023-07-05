<?php

namespace App\Repository;

use App\Entity\ModelDiagramTest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ModelDiagramTest>
 *
 * @method ModelDiagramTest|null find($id, $lockMode = null, $lockVersion = null)
 * @method ModelDiagramTest|null findOneBy(array $criteria, array $orderBy = null)
 * @method ModelDiagramTest[]    findAll()
 * @method ModelDiagramTest[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ModelDiagramTestRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ModelDiagramTest::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ModelDiagramTest $entity, bool $flush = true): void
    {
        $this->_em->persist($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function remove(ModelDiagramTest $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return ModelDiagramTest[] Returns an array of ModelDiagramTest objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('m.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?ModelDiagramTest
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
